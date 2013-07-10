Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwvSz-0006Ny-LP
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 14:34:02 +0000
Date: Wed, 10 Jul 2013 10:33:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130710143309.GD5819@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com>
 <51DBA47C.8090708@jp.fujitsu.com> <20130710104252.479a0f92@holzheu>
 <51DD2E5A.1030200@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DD2E5A.1030200@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Wed, Jul 10, 2013 at 06:50:18PM +0900, HATAYAMA Daisuke wrote:

[..]
> If you want to avoid looking up vmcore_list that takes linear time w.r.t. the number
> of the elements, you can still calculate the range of offsets in /proc/vmcore
> corresponding to HSA during /proc/vmcore initialization.
> 
> Also, could you tell me how often and how much the HSA region is during crash dumping?
> I guess the read to HSA is done mainly during early part of crash dumping process only.
> According to the code, it appears at most 64MiB only. Then, I feel performance is not
> a big issue.
> 
> Also, cost of WARN_ONCE() is one memory access only in the 2nd and later calls. I don't
> think it too much overhead...

Hi Hatayama,

I think michael's proposal of just putting in WARN_ONCE for non s390 arch
sounds reasonable. It is simple and meets your need of being able to 
detect that non s390 arch don't make use of mmap() path yet. Introducing
in_valid_fault_range() kind of sounds overkill to me for this issue.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
