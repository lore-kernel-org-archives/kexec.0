Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6ep-00ExbL-L4
 for kexec@lists.infradead.org; Tue, 18 May 2021 20:49:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
Date: Tue, 18 May 2021 20:49:34 +0000
Message-ID: <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-3-arnd@kernel.org>
In-Reply-To: <20210517203343.3941777-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Arnd Bergmann' <arnd@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Arnd Bergmann
> Sent: 17 May 2021 21:34
> 
> The compat move_pages() implementation uses compat_alloc_user_space()
> for converting the pointer array. Moving the compat handling into
> the function itself is a bit simpler and lets us avoid the
> compat_alloc_user_space() call.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/migrate.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b234c3f3acb7..a68d07f19a1a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1855,6 +1855,23 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
>  	mmap_read_unlock(mm);
>  }
> 
> +static int put_compat_pages_array(const void __user *chunk_pages[],
> +				  const void __user * __user *pages,
> +				  unsigned long chunk_nr)
> +{

Should that be get_compat_pages_array() ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
