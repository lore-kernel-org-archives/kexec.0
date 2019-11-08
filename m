Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTAHQ-0003Cp-MZ
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 19:50:50 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues
Date: Fri, 8 Nov 2019 19:48:07 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03594B6D@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03594B01@BPXM09GP.gisp.nec.co.jp>
 <2055125554.11167146.1573240335556.JavaMail.zimbra@redhat.com>
In-Reply-To: <2055125554.11167146.1573240335556.JavaMail.zimbra@redhat.com>
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


> -----Original Message-----
> > I dropped the ELF32 part from the crash patch, could you check this?
> > https://github.com/k-hagio/crash/tree/support-extended-elf.v2
> 
> Thanks Kazu -- the patch is queued for crash-7.2.8:
> 
>   https://github.com/crash-utility/crash/commit/c0bbd8fae4271159aee9e643350781909484c92f
> 
> Dave
> 

Thank you!

As for makedumpfile, I will take some more time to support refiltering
but it will not affect crash side.

Kazu

> 
> > This is for makedumpfile:
> > https://github.com/k-hagio/makedumpfile/tree/support-extended-elf.v2
> >
> > I will post the updated makedumpfile patch later for public review,
> > and would like to apply it next week.
> >
> > Thanks,
> > Kazu
> >
> >
> >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
