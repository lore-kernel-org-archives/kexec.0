From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 19 May 2022 09:07:25 -0300
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <YoXr2AD+Jc/ukUhJ@alley>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com> <YoOpyW1+q+Z5as78@alley>
 <YoSnGmBJ3kYs5WMf@alley> <fbbd0a8d-2ef4-4a39-4b75-354918e85778@igalia.com>
 <YoXr2AD+Jc/ukUhJ@alley>
Message-ID: <73ade79a-5d76-0e68-708c-f14d3665a7d2@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 19/05/2022 04:03, Petr Mladek wrote:
> [...]
> I would ignore it for now. If anyone would want to safe the log
> then they would need to read it. They will most likely use
> the existing kmsg_dump() infastructure. In fact, they should
> use it to avoid a code duplication.
> 
> Best Regards,
> Petr

Cool, thanks! I agree, let's expect people use kmsg_dump() as they should =)

