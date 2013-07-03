Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuNr3-0007yn-Cm
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 14:16:22 +0000
Date: Wed, 3 Jul 2013 10:15:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 2/5] s390/vmcore: Use ELF header in new memory feature
Message-ID: <20130703141529.GB1460@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-3-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702162322.GD22603@redhat.com>
 <20130703095913.6f6d145d@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130703095913.6f6d145d@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Jul 03, 2013 at 09:59:13AM +0200, Michael Holzheu wrote:
> On Tue, 2 Jul 2013 12:23:23 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Jul 01, 2013 at 09:32:36PM +0200, Michael Holzheu wrote:
> > 
> > [..]
> > > +ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> > > +{
> > > +	void *src = (void *)(unsigned long)*ppos;
> > > +
> > > +	src = elfcorehdr_newmem ? src : src - OLDMEM_BASE;
> > 
> > Seriously, we need to get rid of all this OLDMEM_BASE logic in s390
> > specific code. For regular kdump, it is no different than x86. Only
> > special handling required for zfcpdump for HSA region.
> > 
> > Why do we need above. Is it to cover the case where elfcorehdr have
> > been prepared by user space? Are elf headers initially stored in
> > reserved region and then swapped. Why do we need to swap these or
> > why kexec-tools could not take care of swapping it.
> 
> I know it is confusing. The "src - OLDMEM_BASE" term is currently
> needed because of the swap issue that we have discussed already. We
> load the ELF header into reserved memory
> [OLDMEM_BASE, OLDMEM_BASE + OLDMEM_SIZE] that is swapped with
> [0, OLDMEM_SIZE]. So the ELF header address has to be adjusted.

Can't kexec-tools could easily do this swapping and modify elfcorehdr=
command line accordingly so that second kernel does not have to do
swapping for ELF headers.

And for PT_LOAD segment swapping, we could use ELF header swapping trick
(again in kexec-tools).

After above two changes I think all the OLD_MEMBASE magic will go away
from s390 code and only HSA region special handling will remain.

This brings it inline with x86 code and it becomes easier to understand
the s390 code. Otherwise there so may special corner cases that it is
easy to get lost.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
