From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 23 May 2022 17:40:07 -0300
Subject: [PATCH 12/30] parisc: Replace regular spinlock with spin_trylock
 on panic path
In-Reply-To: <6a7c924a-54a9-c5ea-8a9d-3ea92987b436@gmx.de>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-13-gpiccoli@igalia.com>
 <6a7c924a-54a9-c5ea-8a9d-3ea92987b436@gmx.de>
Message-ID: <0dda86c0-3a54-8c70-d1e7-18bbb4d41bab@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 28/04/2022 13:55, Helge Deller wrote:
> [...]
> You may add:
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> 
> Helge

Hi Helge, do you think would be possible to still pick this one for
v5.19 or do you prefer to hold for the next release?

I'm working on V2, so if it's merged for 5.19 I won't send it again.
Thanks,


Guilherme

