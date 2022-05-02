From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 2 May 2022 08:38:02 -0700
Subject: [PATCH 15/30] bus: brcmstb_gisb: Clean-up panic/die notifiers
In-Reply-To: <20220427224924.592546-16-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-16-gpiccoli@igalia.com>
Message-ID: <eaf3a893-00dd-8717-202e-911b395670e1@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/27/2022 3:49 PM, Guilherme G. Piccoli wrote:
> This patch improves the panic/die notifiers in this driver by
> making use of a passed "id" instead of comparing pointer
> address; also, it removes an useless prototype declaration
> and unnecessary header inclusion.
> 
> This is part of a panic notifiers refactor - this notifier in
> the future will be moved to a new list, that encompass the
> information notifiers only.
> 
> Fixes: 9eb60880d9a9 ("bus: brcmstb_gisb: add notifier handling")
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Not sure if the Fixes tag is warranted however as this is a clean up, 
and not really fixing a bug.
-- 
Florian

