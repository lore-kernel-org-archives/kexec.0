Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WEDCF-000817-Dr
 for kexec@lists.infradead.org; Fri, 14 Feb 2014 07:28:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: Reserved memory estimation for crashkernel=
Date: Fri, 14 Feb 2014 07:21:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971E9670@BPXM01GP.gisp.nec.co.jp>
References: <52F8A896.1050205@ubuntu.com>
In-Reply-To: <52F8A896.1050205@ubuntu.com>
Content-Language: ja-JP
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
To: Louis Bouchard <louis.bouchard@ubuntu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Louis,

On 2014/02/10 19:24:05, kexec <kexec-bounces@lists.infradead.org> wrote:
> Hello,
>
> I would be interested to know if there is a semi-accurate way to evaluate the
> amount of memory that needs to be reserved and passed to the crashkernel=
> parameter ?
>
> I understand that it is very specific to the environment (system configuration,
> kernel options, etc) but if we could at least know how much memory will be
> required by makedumpfile it would be a good start.

Almost all the memory required by makedumpfile is used for the bitmap,
and its maximum size can be calculated as:

  ((system memory size / page size) / 8) * 2 [byte]

Additional requirement size will be a few MByte at most, so estimating
for makedumpfile is easy.

Moreover, makedumpfile can work even with lower memory since the cyclic mode
was introduced. Then, the performance degradation caused by multi-cycle
processing is very small according to the report below:

  https://lkml.org/lkml/2013/3/26/914
  (Please see the "Performance degradation in cyclic mode" paragraph.)


Thanks
Atsushi Kumagai

> 
> Maybe we can imagine an enhancement to makedumpfile to have it evaluate a value
> that could provide some kind of estimate.
> 
> TIA,
> 
> Kind regards,
> 
> ...Louis
> -- 
> Louis Bouchard
> Software engineer,
> Ubuntu
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
