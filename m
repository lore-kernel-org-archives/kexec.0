Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QtXXy-0004hY-RV
	for kexec@lists.infradead.org; Wed, 17 Aug 2011 04:16:07 +0000
Date: Wed, 17 Aug 2011 12:49:41 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [UPDATED PATCH v2 8/8] makedumpfile: Add erase information in
	ELF formatted dumpfile
Message-Id: <20110817124941.445ca9b7.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E4A52AC.2060407@linux.vnet.ibm.com>
References: <20110517200715.12740.67863.stgit@mars.in.ibm.com>
	<20110715091602.GA719@in.ibm.com>
	<20110815145451.44f9d605.oomichi@mxs.nes.nec.co.jp>
	<4E4A52AC.2060407@linux.vnet.ibm.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Tue, 16 Aug 2011 16:51:16 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >>  /*
> >> + * ELF note section for erase information
> >> + *
> >> + * According to elf.h the unused values are 0x15(21) through 0xff. The value
> >> + * range 0x1XX, 0x2XX and 0x3XX is been used for PPC, i386 and s390
> >> + * respectively.
> >> + *
> >> + * Using 0xff to be on safer side so that any new Elf Note addition in elf.h
> >> + * after 0x15 value would not clash.
> >> + */
> >> +#ifndef NT_ERASE_INFO
> >> +#define NT_ERASE_INFO (0xff)	/* Contains erased information. */
> >> +#endif
> >> +#define ERASEINFO_NOTE_NAME		"ERASEINFO"
> >> +#define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))
> > 
> > I feel NT_ERASE_INFO(0xff) is not safe and we can use ERASEINFO_NOTE_NAME
> > instead.
> 
> Do you mean having n_type set to '0' and just using
> 'ERASEINFO_NOTE_NAME' to identify the eraseinfo note?

Yes, that is I wanted to say. thanks.

> if Yes, then I think I am ok with that.

OK, I have merged the above change(commit: 8b8f13e6e84ad628a54bbe2d930aa15224ef5d92)
into the filter-out-devel branch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
