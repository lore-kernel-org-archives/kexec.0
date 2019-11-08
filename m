Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT9gD-0005Nx-Vr
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 19:12:23 +0000
Date: Fri, 8 Nov 2019 14:12:15 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2055125554.11167146.1573240335556.JavaMail.zimbra@redhat.com>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03594B01@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03594B01@BPXM09GP.gisp.nec.co.jp>
Subject: Re: makedumpfile: ELF format issues
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> Hi Dave,
> 
> > -----Original Message-----
> > > > It is possible that the issue occurs on general systems if they have
> > > > large memory, so I'm going to proceed with those patches.
> > >
> > > Hi Kazu,
> > >
> > > Do you want me to go ahead with the crash utility patch?  It looks
> > > safe enough to apply, and I did test it to make sure there were no
> > > ill-effects with sample ELF dumpfiles.
> > 
> > Oh, thank you for your attention and testing.
> > 
> > I'm dropping the ELF32 parts of them, because I think they will not be
> > used in the future.  (I estimate the theoretical minimum memory size
> > that makedumpfile could use the extended numbering is 64GB+256MB on
> > 4k page system.)
> 
> I dropped the ELF32 part from the crash patch, could you check this?
> https://github.com/k-hagio/crash/tree/support-extended-elf.v2

Thanks Kazu -- the patch is queued for crash-7.2.8:
  
  https://github.com/crash-utility/crash/commit/c0bbd8fae4271159aee9e643350781909484c92f

Dave


> This is for makedumpfile:
> https://github.com/k-hagio/makedumpfile/tree/support-extended-elf.v2
> 
> I will post the updated makedumpfile patch later for public review,
> and would like to apply it next week.
> 
> Thanks,
> Kazu
> 
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
