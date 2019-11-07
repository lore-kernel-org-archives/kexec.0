Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSpL8-00012r-9U
 for kexec@lists.infradead.org; Thu, 07 Nov 2019 21:29:16 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide
 by zero in print_report()) (Kazuhito Hagio)
Date: Thu, 7 Nov 2019 21:28:48 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03594A21@BPXM09GP.gisp.nec.co.jp>
References: <mailman.7.1573156802.22483.kexec@lists.infradead.org>
 <651227040.10956407.1573157891163.JavaMail.zimbra@redhat.com>
In-Reply-To: <651227040.10956407.1573157891163.JavaMail.zimbra@redhat.com>
Content-Language: en-US
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
To: Dave Anderson <anderson@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Dave,

> -----Original Message-----
> > > I think this will be the one of the causes, and had a look at how
> > > we can fix it.  If you get a vmcore where this pattern occurs,
> > > you can try this tree:
> > > https://github.com/k-hagio/makedumpfile/tree/support-extended-elf
> > >
> > > Then, the crash utility also needs a patch to support a dumpfile
> > > that has more than 64k program headers:
> > > https://github.com/k-hagio/crash/tree/support-extended-elf

> > It is possible that the issue occurs on general systems if they have
> > large memory, so I'm going to proceed with those patches.
> 
> Hi Kazu,
> 
> Do you want me to go ahead with the crash utility patch?  It looks
> safe enough to apply, and I did test it to make sure there were no
> ill-effects with sample ELF dumpfiles.

Oh, thank you for your attention and testing.

I'm dropping the ELF32 parts of them, because I think they will not be
used in the future.  (I estimate the theoretical minimum memory size
that makedumpfile could use the extended numbering is 64GB+256MB on
4k page system.)

I will let you know when it gets prepared.

Thanks!
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
