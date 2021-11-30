Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 30 Nov 2021 16:05:25 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v16 09/11] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Message-ID: <YaagJQqq2Cx2zyVw@robh.at.kernel.org>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123124646.1995-10-thunder.leizhen@huawei.com>
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
Cc: Vivek Goyal <vgoyal@redhat.com>, Chen Zhou <dingguo.cz@antgroup.com>, Frank Rowand <frowand.list@gmail.com>, linux-doc@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Eric Biederman <ebiederm@xmission.com>, Feng Zhou <zhoufeng.zf@bytedance.com>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 23 Nov 2021 20:46:44 +0800, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/fdt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
