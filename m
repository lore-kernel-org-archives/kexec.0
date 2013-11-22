Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjr2s-0006u9-91
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 13:45:19 +0000
Date: Fri, 22 Nov 2013 08:44:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4] makedumpfile: Support to filter dump for kernels that
 use CONFIG_SPARSEMEM_VMEMMAP
Message-ID: <20131122134449.GB4046@redhat.com>
References: <20131122123155.28272.38600.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131122123155.28272.38600.stgit@localhost.localdomain>
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Ken'ichi <oomichi@mxs.nes.nec.co.jp>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Onkar N Mahajan <onmahaja@in.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Dave Young <dyoung@redhat.com>

On Fri, Nov 22, 2013 at 06:01:55PM +0530, Hari Bathini wrote:
> Makedumpfile fails to filter dump for kernels build with CONFIG_SPARSEMEM_VMEMMAP
> enabled as it fails to do vmemmap translations. So far, makedumpfile on ppc64 never
> had to deal with vmemmap addresses (vmemmap regions) seperately to filter ppc64
> crash dumps as vmemmap regions where mapped in zone normal. But with the inclusion
> of CONFIG_SPARSEMEM_VMEMMAP config option in recent kernels, vmemmap memory regions
> are mapped outside zone normal. There is a need to handle vmemmap to physical address
> translation seperately in this scenario. This patch provides support in makedumpfile
> tool to do vmemmap to physical address translation when vmemmap regions are mapped
> outside zone normal. Some kernel symbols are needed in vmcoreinfo for this changes to
> be effective. The kernel patch that adds the necessary symbols to vmcoreinfo has been
> posted to linuxppc devel mailing list. This patch is influenced by vmemmap to physical
> address translation support code in crash utility. It is has been tested successfully
> at all dump filtering levels on kernel dumps that have CONFIG_SPARSEMEM_VMEMMAP enabled
> and kernel dumps with CONFIG_SPARSEMEM_VMEMMAP disabled as well. Also, successfully
> tested dump filtering on already filtered vmcores (re-filtering).

Please column width smaller (say 70) for changelogs. This looks messy.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
