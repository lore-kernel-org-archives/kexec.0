Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ke3VN-0005wv-6N
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 07:55:49 +0000
Date: Fri, 12 Sep 2008 09:55:48 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH]IA64: assign a distinguishable label to uncached memory
	in /proc/iomem
Message-ID: <20080912095548.54471a93@kepler.site>
In-Reply-To: <48C9A2F8.3060308@sgi.com>
References: <48C9A2F8.3060308@sgi.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Jack Steiner <steiner@sgi.com>, linux-ia64@vger.kernel.org

* Jay Lan <jlan@sgi.com> [2008-09-11]: 

> -				} else {
> -					name = "System RAM";
> -				}
> +				} else if (md->attribute == EFI_MEMORY_UC)
> +						name = "Uncached RAM";
> +					else
> +						name = "System RAM";
                                ^^^^^^^^

Isn't that too much indent, i.e. shouldn't that be

--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -1232,9 +1232,10 @@ efi_initialize_iomem_resources(struct re
                                if (md->attribute & EFI_MEMORY_WP) {
                                        name = "System ROM";
                                        flags |= IORESOURCE_READONLY;
-                               } else {
+                               } else if (md->attribute ==
EFI_MEMORY_UC)
+                                       name = "Uncached RAM";
+                               else
                                        name = "System RAM";
-                               }
                                break;



Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
