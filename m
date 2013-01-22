Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxgB8-00044D-VQ
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 15:54:27 +0000
Message-ID: <50FEB620.3020805@zytor.com>
Date: Tue, 22 Jan 2013 09:54:08 -0600
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <1358868049-19884-3-git-send-email-trenn@suse.de>
In-Reply-To: <1358868049-19884-3-git-send-email-trenn@suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, yinghai@kernel.org, vgoyal@redhat.com

On 01/22/2013 09:20 AM, Thomas Renninger wrote:
> From: Yinghai Lu <yinghai@kernel.org>
> 
> kdump voided the whole original e820 map and half way made
> it up via memmap= options passed via kdump boot params again.
> 
> But this is conceptionally wrong. The whole original memory ranges
> which are declared reserved, ACPI data/nvs or however are not usable
> must stay the same and get honored by the kdump kernel.
> 
> Therefore memmap=resetusablemap gets introduced.
> kdump passes this one and only the usable e820 ranges are removed.
> kdump passes the usable ranges to use via memmap=x@y parameter(s).
> The not usable e820 ranges are preserved.
> 
> This for example fixes mmconf (extended PCI config access) and
> possibly other kernel parts which rely on remapped memory to be
> in reserved or ACPI (data/nvs) declared e820 memory areas.
> 
> Tested-by: Thomas Renninger <trenn@suse.de>
> Reviewed-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <trenn@suse.de>

Tested-by: and Reviewed-by: are rather redundant with Signed-off-by:.
Also, you should have a Signed-off-by: from the author (Yinghai).

However, when thinking about it this really doesn't seem to be the right
interface, either.  Something like "memmap=reserveram" which turns all
RAM areas into reserved areas, which can then be overridden by memmap=
options would make more sense.

Even more sense would be to pass the modified memmap to kexec...

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
