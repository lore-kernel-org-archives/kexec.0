Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OxpSi-0005Zc-C0
	for kexec@lists.infradead.org; Mon, 20 Sep 2010 23:07:52 +0000
Message-ID: <4C97E9A6.6030909@kernel.org>
Date: Tue, 21 Sep 2010 01:09:26 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: kvm kdump regression
References: <1841599922.1349991284977843873.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1841599922.1349991284977843873.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
To: caiqian@redhat.com
Cc: graff yang <graff.yang@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, dhowells@redhat.com, sonic adi <sonic.adi@gmail.com>, Chris Lalancette <clalance@redhat.com>, Avi Kivity <avi@redhat.com>

Hello,

Thanks a lot for testing.  Can you please verify whether the following
patch fixes the problem?

diff --git a/mm/percpu.c b/mm/percpu.c
index 58c572b..c76ef38 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1401,9 +1401,9 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,

 			if (pcpu_first_unit_cpu == NR_CPUS)
 				pcpu_first_unit_cpu = cpu;
+			pcpu_last_unit_cpu = cpu;
 		}
 	}
-	pcpu_last_unit_cpu = cpu;
 	pcpu_nr_units = unit;

 	for_each_possible_cpu(cpu)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
