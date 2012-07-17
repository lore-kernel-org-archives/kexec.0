Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sr6zP-0000Bz-MJ
 for kexec@lists.infradead.org; Tue, 17 Jul 2012 12:35:03 +0000
Date: Tue, 17 Jul 2012 14:34:18 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120717123418.GA28781@aepfle.de>
References: <20120710180953.GB20075@aepfle.de>
 <CC223C2F.3817C%keir.xen@gmail.com>
 <20120715160653.GA22779@aepfle.de>
 <20120716154647.GC13540@phenom.dumpdata.com>
 <20120717102456.GA8197@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120717102456.GA8197@aepfle.de>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Keir Fraser <keir.xen@gmail.com>, Jan Beulich <JBeulich@suse.com>, Daniel Kiper <dkiper@net-space.pl>

On Tue, Jul 17, Olaf Hering wrote:

To make this robust against allocation errors I will change it to

       do {

> +	/* Allocate new mfn for previous pfn */
> +	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);

       } while (rc == 0);

> +
> +	/* Make sure the previous pfn is really connected to a (new) mfn */
> +	BUG_ON(rc != 1);

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
