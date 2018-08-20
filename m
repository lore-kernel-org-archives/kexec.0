Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frsok-0000l9-79
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 22:38:36 +0000
Date: Tue, 21 Aug 2018 06:38:17 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
Message-ID: <20180820151901.GA29313@MiWiFi-R3L-srv>
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
 <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
 <20180820121721.GA4113@MiWiFi-R3L-srv>
 <20180820122131.GB4113@MiWiFi-R3L-srv>
 <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chris Clayton <chris2553@googlemail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 08/20/18 at 04:12pm, Chris Clayton wrote:
> 
> 
> On 20/08/2018 13:21, Baoquan He wrote:
> > Hi Chris,
> > 
> > On 08/20/18 at 08:17pm, Baoquan He wrote:
> >> In response to a change in binutils, commit b21ebf2fb4c
> >> (x86: Treat R_X86_64_PLT32 as R_X86_64_PC32) was applied to
> >> the linux kernel during the 4.16 development cycle and has
> >> since been backported to earlier stable kernel series. The
> >> change results in the failure message in $SUBJECT when
> >> rebooting via kexec.
> >>
> >> Fix this by replicating the change in kexec.
> >>
> 
> OK.
> 
> >> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> > 
> > I adjusted the patch log a little bit, you have tested it on upstream
> > kernel, right?
> > 
> 
> At the time of my original message (25 July 2018), 4.18.0-rc6+ was the latest upstream. I tested my change on that and
> on the latest stable 4.14 series kernel, which was 4.14.57. I've just tested it with 4.18.3 and 4.14.65 and it works
> fine. I don't have a 4.19 development kernel installed at the moment - I'm busy with other stuff.

I think it's fine and enough, ack this patch.

Acked-by: Baoquan He <bhe@redhat.com>

By the way, feel free to repost with this format so that Simon won't
miss it. And you can add my ack when you repost. Surely you can also
wait for Simon or ping him later in this threaad.


Thanks
Baoquan
> 
> 
> > Thanks
> > Baoquan
> > 
> >> ---
> >>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> >> index 7fdde73..db85b44 100644
> >> --- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> >> +++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> >> @@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
> >>  			goto overflow;
> >>  		break;
> >>  	case R_X86_64_PC32: 
> >> +	case R_X86_64_PLT32:
> >>  		*(uint32_t *)location = value - address;
> >>  		break;
> >>  	default:
> >> -- 
> >> 2.13.6
> >>
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
