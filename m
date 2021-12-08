Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muoe7-00BDKU-54
 for kexec@lists.infradead.org; Wed, 08 Dec 2021 04:33:36 +0000
Date: Tue, 7 Dec 2021 20:33:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-Id: <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
In-Reply-To: <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
 <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: John Donnelly <John.p.donnelly@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, linux-mm@kvack.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, kexec@lists.infradead.org, rppt@linux.ibm.com

On Mon, 6 Dec 2021 22:03:59 -0600 John Donnelly <John.p.donnelly@oracle.com> wrote:

> On 12/6/21 9:16 PM, Baoquan He wrote:
> > Sorry, forgot adding x86 and x86/mm maintainers
> 
> Hi,
> 
>    These commits need applied to Linux-5.15.0 (LTS) too since it has the 
> original regression :
> 
>   1d659236fb43 ("dma-pool: scale the default DMA coherent pool
> size with memory capacity")
> 
> Maybe add "Fixes" to the other commits ?

And cc:stable, please.  "Fixes:" doesn't always mean "should be
backported".

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
