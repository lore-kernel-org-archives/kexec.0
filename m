Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcdn-iport-4.cisco.com ([173.37.86.75])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYYfD-0000av-3u
 for kexec@lists.infradead.org; Tue, 12 May 2020 17:25:58 +0000
Received: from XCH-ALN-002.cisco.com (xch-aln-002.cisco.com [173.36.7.12])
 by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 04CHPnhU022514
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 12 May 2020 17:25:50 GMT
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Subject: [REQUEST] makedumpfile: stream compress flat ELF format with libz
Date: Tue, 12 May 2020 17:25:46 +0000
Message-ID: <20200512172546.GL31850@zorba>
Content-Language: en-US
Content-ID: <72E89CA3326DD64B88C4E935B716E06B@namprd11.prod.outlook.com>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>


Hi,

I created an enhancement request for makedumpfile here,

https://github.com/makedumpfile/makedumpfile/issues/1

I found that compressing a flat core with gzip significantly reduces the size of
the core. Here were my findings,

32G flat elf core -E -F -d 0
33G kdump core -d 0
16G kdump compressed -c -d 0
1.9G flat elf core stream compressed with gzip -E -F -d 0

My feature request was to implement an option inside makedumpfile to gzip
compress the core output. This can already be accomplished by piping the core
thru the gzip tool, however, because makedumpfile already links against libz
having the option for makedumpfile to do it allows the gzip tools to be removed
from the crash kernels initramfs there by reducing the size.

Kazuhito Hagio had suggest adding the -C option instead of repurposing -c to do
this.

So a resulting command line might looks like this,

makedumpfile -C -F -E -d 31 /proc/vmcore core.gz

Thanks,
Daniel
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
