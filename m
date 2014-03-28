Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Fri, 28 Mar 2014 11:44:33 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1897155363.7224032.1396021473883.JavaMail.zimbra@redhat.com>
In-Reply-To: <53356590.3030005@huawei.com>
References: <mailman.28599.1395907790.1059.kexec@lists.infradead.org>
 <420609342.5318732.1395929059090.JavaMail.zimbra@redhat.com>
 <53356590.3030005@huawei.com>
Subject: Re: [PATCH 0/3] add LPAE support for kexec and kernel (Liu Hua)
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Liu hua <sdu.liu@huawei.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>



----- Original Message -----
> On 2014/3/27 22:04, Dave Anderson wrote:
> > 
> > 
> > ----- Original Message -----
> > 
> >> The patch series introduce LPAE support for user space
> >> utility kexec(the last) and ARM linux kernel(the others).
> >>
> >> I have tested the patch series in armA15 platform which have
> >> more than 4G memory.
> > 
> > Hello Liu,
> > 
> > I'm curious how you tested this?  The crash utility does not have
> > any specific support for LPAE on ARM, and a couple years ago I
> > asked on the crash-utility mailing list whether any of the ARM
> > developers were working on it.  But at that time none of them were
> > working with LPAE.  I see that you are on the crash-utility mailing
> > list -- are you planning to post follow-up patches to the crash-utility?
> > 
> > Thanks,
> >   Dave
> 
> Yes, you are very "sensitive"! our team has worked on it for a while. And
> we went through the whole kdump process for LPAE enabled ARM. Our changes
> include kexec-tools, makedumpfile, crash utility and the kernel.
> 
> But we did that in a rather limited time. So some patches are silly and
> need to be reconstructed before submission. In addition, my job is quit
> full now. So I decide to post the patch series that are clear and
> independent of the others at first.
> 
> But I got no response from the linux-arm and kexec mailinglist. What about
> your opinion about the feature of LPAE support for kdump related tools
> including crash utility and the kernel?

I can't speak for the linux-arm and kexec mailing lists, but certainly 
when you post your crash-related patches on the crash-utility mailing 
list, I'll review, respond, and get them in place as soon as possible.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
