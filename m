Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGJjM-0003QG-Nt
 for kexec@lists.infradead.org; Sat, 27 Oct 2018 08:14:02 +0000
Date: Sat, 27 Oct 2018 16:13:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027081343.GA1884@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181026222517.GB26927@nazgul.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: lijiang <lijiang@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On 10/27/18 at 12:25am, Borislav Petkov wrote:
> On Fri, Oct 26, 2018 at 06:24:40PM +0200, Petr Tesarik wrote:
> > But we need the MSR value from the panic kernel environment, not while
> > the production kernel is still running, right?
> 
> Actually, we need only the encryption bit number (and it should be 0
> otherwise to denote SME wasn't enabled).
> 
> I guess something like
> 
> 	VMCOREINFO_NUMBER(sme_mask);

Yes, agree. So sme_me_mask itself or the encryption bit number, both is
fine.

We need read and parse the memory content of crashed kernel which
is mapped to /prov/vmcore by user space makedumpfile. Not only is it
because user space makedumpfile can't access and get if it's sme
enabled from system, we may use cp to copy /proc/vmcore to a file
directly, then analyze it in another compupter. This often happen when
there's something wrong with makedumpfile, we need debug makedumpfile
with the complete copied file.

And only telling whether sme is enabled might be not enough. Since AMD
CPU might extend to support 5-level, then the current fixed bit positon
47 would need be changed.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
