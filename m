Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0MAN-0001kL-BQ
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 20:18:20 +0000
Message-ID: <491B398C.9090207@goop.org>
Date: Wed, 12 Nov 2008 12:16:12 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Always use 64 bit addresses for the firmware memory map
References: <1226519089-21647-1-git-send-email-bwalle@suse.de>
In-Reply-To: <1226519089-21647-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Bernhard Walle wrote:
> I had a problem that on i386 without PAE enabled the firmware memory map was
> wrong because a 64 bit address has been truncated:
>
>         0000000000000000-000000000009f400 (System RAM)
>         000000000009f400-00000000000a0000 (reserved)
>         00000000fec10000-00000000fec11000 (reserved)
>         00000000fec20000-00000000fec21000 (reserved)
>         00000000fee00000-00000000fee10000 (reserved)
>         00000000ff800000-0000000100000000 (reserved)
>  --->   0000000000000000-00000000fffff000 (System RAM)  <---
>         00000000000f0000-0000000000100000 (reserved)
>         0000000000100000-00000000f57fa000 (System RAM)
>         00000000f57fa000-00000000f5800000 (ACPI Tables)
>         00000000fdc00000-00000000fdc01000 (reserved)
>         00000000fdc10000-00000000fdc11000 (reserved)
>         00000000fdc20000-00000000fdc21000 (reserved)
>         00000000fdc30000-00000000fdc31000 (reserved)
>         00000000fec00000-00000000fec01000 (reserved)
>
> Just always using 64 bit is the most sane approach in my opinion.
>
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  drivers/firmware/memmap.c    |   17 +++++++----------
>  include/linux/firmware-map.h |   12 +++++-------
>  2 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
> index 3bf8ee1..010afde 100644
> --- a/drivers/firmware/memmap.c
> +++ b/drivers/firmware/memmap.c
> @@ -31,8 +31,8 @@
>   * information is necessary as for the resource tree.
>   */
>  struct firmware_map_entry {
> -	resource_size_t		start;	/* start of the memory range */
> -	resource_size_t		end;	/* end of the memory range (incl.) */
>   

resource_size_t should always be 64-bit on PAE now.

    J

> +	uint64_t		start;	/* start of the memory range */
> +	uint64_t		end;	/* end of the memory range (incl.) */
>  	const char		*type;	/* type of the memory range */
>  	struct list_head	list;	/* entry for the linked list */
>  	struct kobject		kobj;   /* kobject for each entry */
> @@ -101,7 +101,7 @@ static LIST_HEAD(map_entries);
>   * Common implementation of firmware_map_add() and firmware_map_add_early()
>   * which expects a pre-allocated struct firmware_map_entry.
>   **/
> -static int firmware_map_add_entry(resource_size_t start, resource_size_t end,
> +static int firmware_map_add_entry(uint64_t start, uint64_t end,
>  				  const char *type,
>  				  struct firmware_map_entry *entry)
>  {
> @@ -132,8 +132,7 @@ static int firmware_map_add_entry(resource_size_t start, resource_size_t end,
>   *
>   * Returns 0 on success, or -ENOMEM if no memory could be allocated.
>   **/
> -int firmware_map_add(resource_size_t start, resource_size_t end,
> -		     const char *type)
> +int firmware_map_add(uint64_t start, uint64_t end, const char *type)
>  {
>  	struct firmware_map_entry *entry;
>  
> @@ -157,7 +156,7 @@ int firmware_map_add(resource_size_t start, resource_size_t end,
>   *
>   * Returns 0 on success, or -ENOMEM if no memory could be allocated.
>   **/
> -int __init firmware_map_add_early(resource_size_t start, resource_size_t end,
> +int __init firmware_map_add_early(uint64_t start, uint64_t end,
>  				  const char *type)
>  {
>  	struct firmware_map_entry *entry;
> @@ -175,14 +174,12 @@ int __init firmware_map_add_early(resource_size_t start, resource_size_t end,
>  
>  static ssize_t start_show(struct firmware_map_entry *entry, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "0x%llx\n",
> -		(unsigned long long)entry->start);
> +	return snprintf(buf, PAGE_SIZE, "0x%llx\n", entry->start);
>  }
>  
>  static ssize_t end_show(struct firmware_map_entry *entry, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "0x%llx\n",
> -		(unsigned long long)entry->end);
> +	return snprintf(buf, PAGE_SIZE, "0x%llx\n", entry->end);
>  }
>  
>  static ssize_t type_show(struct firmware_map_entry *entry, char *buf)
> diff --git a/include/linux/firmware-map.h b/include/linux/firmware-map.h
> index 6e199c8..209a27a 100644
> --- a/include/linux/firmware-map.h
> +++ b/include/linux/firmware-map.h
> @@ -24,21 +24,19 @@
>   */
>  #ifdef CONFIG_FIRMWARE_MEMMAP
>  
> -int firmware_map_add(resource_size_t start, resource_size_t end,
> -		     const char *type);
> -int firmware_map_add_early(resource_size_t start, resource_size_t end,
> -			   const char *type);
> +int firmware_map_add(uint64_t start, uint64_t end, const char *type);
> +int firmware_map_add_early(uint64_t start, uint64_t end, const char *type);
>  
>  #else /* CONFIG_FIRMWARE_MEMMAP */
>  
> -static inline int firmware_map_add(resource_size_t start, resource_size_t end,
> +static inline int firmware_map_add(uint64_t start, uint64_t end,
>  				   const char *type)
>  {
>  	return 0;
>  }
>  
> -static inline int firmware_map_add_early(resource_size_t start,
> -					 resource_size_t end, const char *type)
> +static inline int firmware_map_add_early(uint64_t start, uint64_t end,
> +					 const char *type)
>  {
>  	return 0;
>  }
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
