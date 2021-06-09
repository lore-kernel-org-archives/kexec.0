Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqvqG-00D9jH-0y
 for kexec@lists.infradead.org; Wed, 09 Jun 2021 10:53:49 +0000
Received: by mail-wr1-f69.google.com with SMTP id
 g14-20020a5d698e0000b0290117735bd4d3so10491069wru.13
 for <kexec@lists.infradead.org>; Wed, 09 Jun 2021 03:53:43 -0700 (PDT)
Subject: Re: [PATCH 3/9] arc: remove support for DISCONTIGMEM
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-4-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e9ef94f5-02bc-920b-9e6a-2d234e5bbbc5@redhat.com>
Date: Wed, 9 Jun 2021 12:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-4-rppt@kernel.org>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jonathan Corbet <corbet@lwn.net>, Matt Turner <mattst88@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> DISCONTIGMEM was replaced by FLATMEM with freeing of the unused memory map
> in v5.11.
> 
> Remove the support for DISCONTIGMEM entirely.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
