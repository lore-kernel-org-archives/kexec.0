Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhL9L-0007SX-Q8
 for kexec@lists.infradead.org; Tue, 28 May 2013 14:45:20 +0000
Date: Tue, 28 May 2013 10:44:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130528144447.GE7088@redhat.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130524143644.GD18218@redhat.com>
 <20130524170626.2ac06efe@holzheu>
 <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130525145217.0549138a@holzheu>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Sat, May 25, 2013 at 02:52:17PM +0200, Michael Holzheu wrote:

[..]
> Therefore, if necessary, IMHO we can switch to the ELF header memory
> swap mechanism for s390 in the kernel. Of course we would then also
> have to adjust the (disabled) kexec code.

I think it is a good idea to fix it in s390 kernel so that
copy_oldmem_page() does not do any swapping and fix the ELF header
generation logic and any swapping is done in ELF headers.

Agreed that we need to fixed s390 kexec-tools too. I guess our best
bet would be to parse the kernel version and fix headers only for
newer kernel versions. This assumes that first kernel and second kernel
are same but that's the case for majority of the people anyway. So for
majority of people, change will be backward compatible.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
