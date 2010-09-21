Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OxquB-0005XX-R6
	for kexec@lists.infradead.org; Tue, 21 Sep 2010 00:40:20 +0000
Date: Mon, 20 Sep 2010 20:40:13 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1848241872.1438141285029613564.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4C97E9A6.6030909@kernel.org>
Subject: Re: kvm kdump regression
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: graff yang <graff.yang@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, dhowells@redhat.com, sonic adi <sonic.adi@gmail.com>, Chris Lalancette <clalance@redhat.com>, Avi Kivity <avi@redhat.com>


----- "Tejun Heo" <tj@kernel.org> wrote:

> Hello,
> 
> Thanks a lot for testing.  Can you please verify whether the
> following patch fixes the problem?
Yes, it did.
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 58c572b..c76ef38 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1401,9 +1401,9 @@ int __init pcpu_setup_first_chunk(const struct
> pcpu_alloc_info *ai,
> 
>  			if (pcpu_first_unit_cpu == NR_CPUS)
>  				pcpu_first_unit_cpu = cpu;
> +			pcpu_last_unit_cpu = cpu;
>  		}
>  	}
> -	pcpu_last_unit_cpu = cpu;
>  	pcpu_nr_units = unit;
> 
>  	for_each_possible_cpu(cpu)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
