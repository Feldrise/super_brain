// Simple test script to verify the trouve-mot.fr API works
async function testAPI() {
    try {
        console.log('Testing trouve-mot.fr API...');

        // Test category 19 (ANIMAUX) with 5 words
        const response = await fetch('https://trouve-mot.fr/api/categorie/19/5');

        if (!response.ok) {
            throw new Error(`API request failed with status ${response.status}`);
        }

        const data = await response.json();
        console.log('API Response:', data);

        // Test a few different categories
        const categories = [
            { id: 5, name: 'ALIMENTS' },
            { id: 13, name: 'MOUVEMENTS' },
            { id: 15, name: 'VÊTEMENTS' }
        ];

        for (const category of categories) {
            console.log(`\nTesting category ${category.id} (${category.name}):`);
            const resp = await fetch(`https://trouve-mot.fr/api/categorie/${category.id}/3`);
            const words = await resp.json();
            console.log(words);
        }

    } catch (error) {
        console.error('Error testing API:', error);
    }
}

testAPI();
