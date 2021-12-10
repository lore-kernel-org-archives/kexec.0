Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 10 Dec 2021 10:39:56 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v17 08/10] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Message-ID: <YbOC3NmxXsQb/Te/@robh.at.kernel.org>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-9-thunder.leizhen@huawei.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Chen Zhou <dingguo.cz@antgroup.com>, Randy Dunlap <rdunlap@infradead.org>, "H . Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Feng Zhou <zhoufeng.zf@bytedance.com>, linux-doc@vger.kernel.org

On Fri, 10 Dec 2021 14:55:31 +0800, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  drivers/of/fdt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
