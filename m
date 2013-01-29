Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tzzf0-0005sW-DF
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 01:06:51 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
Date: Tue, 29 Jan 2013 02:05:53 +0100
Message-ID: <6950516.1uefDuthAH@hammer82.arch.suse.de>
In-Reply-To: <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, vgoyal@redhat.com

On Wednesday, January 23, 2013 08:07:19 PM Yinghai Lu wrote:
> On Tue, Jan 22, 2013 at 12:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Tue, Jan 22, 2013 at 8:32 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> >>> Again: Please explain what is bad with this solution.
> >>> I cannot see a better and more robust way for kdump other than
> >>> reserving the original reserved memory areas as declared by the BIOS.
> >> 
> >> It is bad because it creates more complexity than is needed.
> >> 
> >> The whole point is that what we want is simply to switch type 1 to type
> >> X, with the sole exceptions being the areas explicitly reserved for the
> >> kdump kernel.
> > 
> > Do you prefer to  "reserveram" way in attached patch?
> 
> Hi, Thomas,
> 
> Can you please check attached reserveram version on your setup?
> 
> If it is ok, i will put it in for-x86-boot patchset and send it to
> Peter for v3.9.

But this (converting usable memory to reserved one before usable kdump memory
is added) will let machines run into problems again for which the check:
"mmconf area must be in reserved memory" got added?

If, then memory which was usable before has to be converted to a special
E820_KUMP (or whatever type) to make sure existing checks which look for
"is reserved memory" still work the same way as in a productive kernel.

Advantage of this would be that the info what originally was usable
memory is preserved and can be used in future kdump related patches.

So I guess the final patch should be:
   - Add a new e820 type:
        E820_KDUMP_RESERVED /* Originally usable memory where the crashed
                                                    kernel kernel resided in */
  - Use Yinghai's last posted patch, but instead of:
+			e820_update_range(0, ULLONG_MAX, E820_RAM,
+					  E820_RESERVED);
...
+			e820_remove_range(start_at, mem_size, E820_RESERVED, 0);
do:
+			e820_update_range(0, ULLONG_MAX, E820_RAM,
+					  E820_KDUMP_RESERVED);
...
+			e820_remove_range(start_at, mem_size, E820_KDUMP_RESERVED, 0);

  - Come up with another memmap=kdump_reserve_ram memmap option name
    or however it should get named...

If this proposal gets accepted, I can send a tested patch...

       Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
