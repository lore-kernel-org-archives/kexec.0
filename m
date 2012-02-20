Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzOFT-0006VU-B4
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 08:05:31 +0000
Date: Mon, 20 Feb 2012 17:02:53 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH][makedumpfile] sadump: check if given cpu is online in
 per-cpu related helper functions
Message-Id: <20120220170253.e79219aa.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120220.111915.28783507.d.hatayama@jp.fujitsu.com>
References: <20120220.111915.28783507.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hi Hatayama-san,

On Mon, 20 Feb 2012 11:19:15 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Per-cpu helper functions sanity check given cpu ids if they are
> not-minus and less than the maximal but it should have checked if they
> are online. By this mistake, one cannot see generated vmcore correctly
> if sadump collects vmcore when some cpus are offline e.g. using cpu
> hotplug or panic and so all the cpus except for a unique CPU halting.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  sadump_info.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)

Thank you for your patch. 
I will review it and it will be merged into v1.4.4
because I'm preparing the release of v1.4.3 now.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
