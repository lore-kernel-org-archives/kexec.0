Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C396ECD6E5D
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YYu5Y/r+ogUS9B53/mwnMY8XGF0lJLFrksh7/o5BdSs=; b=LTSVst6dt8D/RMCDINNaUUckmL
	tqxd6aodnmfMyTbIpjzc0nqOP5QCmT69lWpGEST/WPqFYNS6/6MrMuO4/ljJmD3FJ1T6c8GSHh3AZ
	3KozUs8uMFCmjtsTw8TZNQdEMhR86a74XXokM001XXndScuXCCdXnVk9x/ktNcS2TT3CU6HoGB+CO
	6O/3VkjEUl1ZUWtLoRmO4rcMtbWkzwhokTORNfUUgOMpVV2a7tTKs3HjLLQ19T+AnGLXnv9aLr6V+
	fl7KXr5bwF77doBwzICrv490tcSezd2Y0pmakU5LudpAOouxdkYThAbt1tHFcEAMK6kPx89G6369A
	9Au2FYVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTgT4-00000009dHG-1Pzd;
	Sun, 31 May 2026 13:44:42 +0000
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTgT2-00000009dGV-2HgG
	for kexec@lists.infradead.org;
	Sun, 31 May 2026 13:44:41 +0000
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-91550d518c0so62398785a.0
        for <kexec@lists.infradead.org>; Sun, 31 May 2026 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780235079; x=1780839879; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYu5Y/r+ogUS9B53/mwnMY8XGF0lJLFrksh7/o5BdSs=;
        b=ir/XC17jiAOdUMl1rTEnBufcs42ITR3Jv1Qa78ccyF2Of87hPwYA0oaD26u8XbRS/0
         5EDJeQPFImDTaVb4xNQ9WyqjjPH0MDeKJf8+5AisMxYgmu++xERYLDlOtWzywIelsBVE
         mrPe+oRFO6lBTGSuQT03PHNdeRDVxkUeqoTQrEwU+FvaawNMeeJiv19K+wZxmctXYY4s
         GWKAW5t246ffcIo5yNWhNT96D2T28b4CMLT3ouapKrFjOD5AWn4Goiu07U++TDFk5B4r
         tQMkO5Udk7R7wH6oXHmsrsJcX0FYcbTRsoak3/n6jajARGXZXdPCnXL0onov3cqSJi2W
         KHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780235079; x=1780839879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYu5Y/r+ogUS9B53/mwnMY8XGF0lJLFrksh7/o5BdSs=;
        b=L2cYDzAkj4U6/VSp4v0StHEqP8Knmly+PLCBdvFI6bgKzcXLO0x7UeTO68SDANljYf
         341HI8XxpKS01ZmSVVSIK793cwMolal6g/RmO0iQWdDUFEp7fCR6IHLkCe921crFUvUa
         lFzFNnLIjFfPiHH2VHNmVC/dTpguqlB0d4TVYbC528fSPKzAtFUm5BxfdAmWiWsYvB73
         7tK6mSsRm3Y4jH8zVbUbMG4POC93bbwqPFT7+LxjUBo5gzUsF3TK4DPtXbrc82jspsVp
         +cnn8JVn3QrnOnjKuz4AfIWlw4wBuhWl2lxyakBsQ8fFKwb4jAo0WDMRuRLLnehSYNjF
         VWIg==
X-Forwarded-Encrypted: i=1; AFNElJ9Pw0ffAuQrFUAX/aTyY0zQnPVWwssFQc2mR4YiMe3vNqfQ/hqStWbQ2Bm9qkTo0gDIletsVw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5U+wQk8U5Ib9e80MO3Pps0xDmj9MKQkP4jmLfXbU8nzwfLD+q
	NvErZGdO5zTZyUon+slO9KUEm1kOhgI59ksKRRfCsq3I1q+zSsMZ+nbM+CSKzJOlRxs=
X-Gm-Gg: Acq92OGKrSclUwaUY5RZYs1cA0KaUtYdJTEvj6gRYYq/1qh81rcj6ru5B7HPfRSQ9ED
	vQmuvI/Icpc22l02ZAgq78XmSPRy+5PWrJRTiMdS6VNxMYpwWQ2jUKROfq7OyQbIwZXyeJaJO63
	99XVjCGzXoRGcMuYXpWz/fiMkwW14PRjKZzBJ9fwFFGJr6X52XDWJQMcyjpEGKdWdN9e7zaLfMN
	U8FQsT0lSNtntMGTHw44ClUyh47VQSlwbiE/4HzP5lj0W77ipO/p177D4tr0QhR/c6pr39RWkyc
	293bxYIu32yA6v7tBdri9csFVzyQ3na4ffBYnQN2hQNlqej8qYhlY7H7vNYHXe2jKQiMYBGlIPI
	yXWBDTtUjEt7Fog5hOWBMvBFExca47SLZUTNBaDr4xRvYzTbdwDkq2W9QZbFBu2/hd1tERZJTrp
	skw9WugpK0zq1TtcNQ5fRxJuzNfB/pPS0mPGStnYfrMuBy72DwRA+PclQTtLcAVQ==
X-Received: by 2002:a05:620a:2307:10b0:914:dbfb:6f7f with SMTP id af79cd13be357-9153da3e110mr804121485a.51.1780235079179;
        Sun, 31 May 2026 06:44:39 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244ad25sm750256085a.3.2026.05.31.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:44:38 -0700 (PDT)
Date: Sun, 31 May 2026 13:44:36 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	pasha.tatashin@soleen.com, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com, roman.gushchin@linux.dev
Subject: Re: [PATCH v4 04/13] liveupdate: register luo_ser as KHO subtree
Message-ID: <ahw6Bqllb0CJ88mR@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530221938.115978-5-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_064440_623179_E0DF7B88 
X-CRM114-Status: GOOD (  36.28  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 05-30 22:19, Pasha Tatashin wrote:
> Entirely remove the LUO FDT wrapper since the FDT only carries the
> compatible string and the pointer to the centralized struct luo_ser.
> Instead, register the struct luo_ser via the KHO raw subtree
> API, placing the compatibility string inside the structure itself.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho/abi/luo.h  | 57 +++++++++---------------
>  kernel/liveupdate/luo_core.c | 85 +++++++++++-------------------------
>  2 files changed, 46 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 1b2f865a771a..9a4fe491812b 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -10,11 +10,11 @@
>   *
>   * Live Update Orchestrator uses the stable Application Binary Interface
>   * defined below to pass state from a pre-update kernel to a post-update
> - * kernel. The ABI is built upon the Kexec HandOver framework and uses a
> - * Flattened Device Tree to describe the preserved data.
> + * kernel. The ABI is built upon the Kexec HandOver framework and registers
> + * the central `struct luo_ser` via the KHO raw subtree API.
>   *
> - * This interface is a contract. Any modification to the FDT structure, node
> - * properties, compatible strings, or the layout of the `__packed` serialization
> + * This interface is a contract. Any modification to the structure fields,
> + * compatible strings, or the layout of the `__packed` serialization
>   * structures defined here constitutes a breaking change. Such changes require
>   * incrementing the version number in the relevant `_COMPATIBLE` string to
>   * prevent a new kernel from misinterpreting data from an old kernel.
> @@ -23,31 +23,15 @@
>   * however, backward/forward compatibility is only guaranteed for kernels
>   * supporting the same ABI version.
>   *
> - * FDT Structure Overview:
> + * KHO Structure Overview:
>   *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
> - *   This entry contains an FDT with the following layout:
> - *
> - *   .. code-block:: none
> - *
> - *     / {
> - *         compatible = "luo-v2";
> - *         luo-abi-header = <phys_addr_of_luo_ser>;
> - *     };
> - *
> - * Main LUO Node (/):
> - *
> - *   - compatible: "luo-v2"
> - *     Identifies the overall LUO ABI version.
> - *   - luo-abi-header: u64
> - *     The physical address of `struct luo_ser`.
> + *   This entry contains the `struct luo_ser` structure.
>   *
>   * Serialization Structures:
> - *   The FDT properties point to memory regions containing arrays of simple,
> - *   `__packed` structures. These structures contain the actual preserved state.
> - *
>   *   - struct luo_ser:
>   *     The central ABI structure that contains the overall state of the LUO.
> - *     It includes the liveupdate-number and pointers to sessions and FLBs.
> + *     It includes the compatibility string, the liveupdate-number, and pointers
> + *     to sessions and FLBs.
>   *
>   *   - struct luo_session_header_ser:
>   *     Header for the session array. Contains the total page count of the
> @@ -78,26 +62,27 @@
>  #ifndef _LINUX_KHO_ABI_LUO_H
>  #define _LINUX_KHO_ABI_LUO_H
>  
> +#include <linux/align.h>
>  #include <uapi/linux/liveupdate.h>
>  
>  /*
> - * The LUO FDT hooks all LUO state for sessions, fds, etc.
> + * The LUO state is registered under this KHO entry name.
>   */
> -#define LUO_FDT_SIZE		PAGE_SIZE
> -#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
> -#define LUO_FDT_COMPATIBLE	"luo-v2"
> -#define LUO_FDT_ABI_HEADER	"luo-abi-header"
> +#define LUO_KHO_ENTRY_NAME	"LUO"
> +#define LUO_ABI_COMPATIBLE	"luo-v3"
> +#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
>  
>  /**
>   * struct luo_ser - Centralized LUO ABI header.
> + * @compatible:     Compatibility string identifying the LUO ABI version.
>   * @liveupdate_num: A counter tracking the number of successful live updates.
>   * @sessions_pa:    Physical address of the first session block header.
>   * @flbs_pa:        Physical address of the FLB header.
>   *
> - * This structure is the root of all preserved LUO state. It is pointed to by
> - * the "luo-abi-header" property in the LUO FDT.
> + * This structure is the root of all preserved LUO state.
>   */
>  struct luo_ser {
> +	char compatible[LUO_ABI_COMPAT_LEN];
>  	u64 liveupdate_num;
>  	u64 sessions_pa;
>  	u64 flbs_pa;
> @@ -111,7 +96,7 @@ struct luo_ser {
>   * @data:        Private data
>   * @token:       User provided token for this file
>   *
> - * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
> + * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
>   */
>  struct luo_file_ser {
>  	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
> @@ -142,7 +127,7 @@ struct luo_file_set_ser {
>   * physical memory preserved across the kexec. It provides the necessary
>   * metadata to interpret the array of session entries that follow.
>   *
> - * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
> + * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
>   */
>  struct luo_session_header_ser {
>  	u64 count;
> @@ -159,7 +144,7 @@ struct luo_session_header_ser {
>   * session) is created and passed to the new kernel, allowing it to reconstruct
>   * the session context.
>   *
> - * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
> + * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
>   */
>  struct luo_session_ser {
>  	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> @@ -180,7 +165,7 @@ struct luo_session_ser {
>   * This structure is located at the physical address specified by the
>   * flbs_pa in luo_ser.
>   *
> - * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
> + * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
>   */
>  struct luo_flb_header_ser {
>  	u64 pgcnt;
> @@ -202,7 +187,7 @@ struct luo_flb_header_ser {
>   * passed to the new kernel. Each entry allows the LUO core to restore one
>   * global, shared object.
>   *
> - * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
> + * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
>   */
>  struct luo_flb_ser {
>  	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index fbc18c5f4230..e261a03a1b47 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -50,7 +50,6 @@
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/luo.h>
>  #include <linux/kobject.h>
> -#include <linux/libfdt.h>
>  #include <linux/liveupdate.h>
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
> @@ -63,8 +62,7 @@
>  
>  static struct {
>  	bool enabled;
> -	void *fdt_out;
> -	void *fdt_in;
> +	struct luo_ser *luo_ser_out;
>  	u64 liveupdate_num;
>  } luo_global;
>  
> @@ -81,11 +79,10 @@ early_param("liveupdate", early_liveupdate_param);
>  
>  static int __init luo_early_startup(void)
>  {
> +	phys_addr_t luo_ser_phys;
>  	struct luo_ser *luo_ser;
> -	int err, header_size;
> -	phys_addr_t fdt_phys;
> -	const void *ptr;
> -	u64 luo_ser_pa;
> +	size_t len;
> +	int err;
>  
>  	if (!kho_is_enabled()) {
>  		if (liveupdate_enabled())
> @@ -94,40 +91,29 @@ static int __init luo_early_startup(void)
>  		return 0;
>  	}
>  
> -	/* Retrieve LUO subtree, and verify its format. */
> -	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
> +	/* Retrieve LUO state from KHO. */
> +	err = kho_retrieve_subtree(LUO_KHO_ENTRY_NAME, &luo_ser_phys, &len);
>  	if (err) {
>  		if (err != -ENOENT) {
> -			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
> -			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
> +			pr_err("failed to retrieve LUO state '%s' from KHO: %pe\n",
> +			       LUO_KHO_ENTRY_NAME, ERR_PTR(err));
>  			return err;
>  		}
>  
>  		return 0;
>  	}
>  
> -	luo_global.fdt_in = phys_to_virt(fdt_phys);
> -	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
> -					LUO_FDT_COMPATIBLE);
> -	if (err) {
> -		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
> -		       LUO_FDT_KHO_ENTRY_NAME, LUO_FDT_COMPATIBLE, err);
> -
> +	if (len < sizeof(*luo_ser)) {
> +		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
>  		return -EINVAL;
>  	}
>  
> -	header_size = 0;
> -	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_ABI_HEADER, &header_size);
> -	if (!ptr || header_size != sizeof(u64)) {
> -		pr_err("Unable to get ABI header '%s' [%d]\n",
> -		       LUO_FDT_ABI_HEADER, header_size);
> -
> +	luo_ser = phys_to_virt(luo_ser_phys);
> +	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
> +		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
>  		return -EINVAL;
>  	}


From Sashiko:
Does this code leak the preserved luo_ser_phys memory on these early validation
failure paths?

Answer: No, a failure in this function leads to a call to 
luo_restore_fail(), which triggers a panic.

Roman: The quality of the Sashiko review is surprisingly weak this time; 
was the model switched from 3.1 Pro to something else?

>  
> -	luo_ser_pa = get_unaligned((u64 *)ptr);
> -	luo_ser = phys_to_virt(luo_ser_pa);
> -
>  	luo_global.liveupdate_num = luo_ser->liveupdate_num;
>  	pr_info("Retrieved live update data, liveupdate number: %lld\n",
>  		luo_global.liveupdate_num);
> @@ -160,37 +146,20 @@ static int __init liveupdate_early_init(void)
>  }
>  early_initcall(liveupdate_early_init);
>  
> -/* Called during boot to create outgoing LUO fdt tree */
> -static int __init luo_fdt_setup(void)
> +/* Called during boot to create outgoing LUO state */
> +static int __init luo_state_setup(void)
>  {
>  	struct luo_ser *luo_ser;
> -	u64 luo_ser_pa;
> -	void *fdt_out;
>  	int err;
>  
> -	fdt_out = kho_alloc_preserve(LUO_FDT_SIZE);
> -	if (IS_ERR(fdt_out)) {
> -		pr_err("failed to allocate/preserve FDT memory\n");
> -		return PTR_ERR(fdt_out);
> -	}
> -
>  	luo_ser = kho_alloc_preserve(sizeof(*luo_ser));
>  	if (IS_ERR(luo_ser)) {
> -		err = PTR_ERR(luo_ser);
> -		goto exit_free_fdt;
> +		pr_err("failed to allocate/preserve LUO state memory\n");
> +		return PTR_ERR(luo_ser);
>  	}
> -	luo_ser_pa = virt_to_phys(luo_ser);
> -
> -	err = fdt_create(fdt_out, LUO_FDT_SIZE);
> -	err |= fdt_finish_reservemap(fdt_out);
> -	err |= fdt_begin_node(fdt_out, "");
> -	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
> -	err |= fdt_property(fdt_out, LUO_FDT_ABI_HEADER, &luo_ser_pa,
> -			    sizeof(luo_ser_pa));
> -	err |= fdt_end_node(fdt_out);
> -	err |= fdt_finish(fdt_out);
> -	if (err)
> -		goto exit_free_luo_ser;
> +
> +	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
> +	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
>  
>  	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
>  	if (err)
> @@ -200,21 +169,17 @@ static int __init luo_fdt_setup(void)
>  	if (err)
>  		goto exit_free_luo_ser;
>  
> -	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
> -
> -	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out,
> -			      fdt_totalsize(fdt_out));
> +	err = kho_add_subtree(LUO_KHO_ENTRY_NAME, luo_ser, sizeof(*luo_ser));
>  	if (err)
>  		goto exit_free_luo_ser;
> -	luo_global.fdt_out = fdt_out;
> +
> +	luo_global.luo_ser_out = luo_ser;
>  
>  	return 0;
>  
>  exit_free_luo_ser:
>  	kho_unpreserve_free(luo_ser);
> -exit_free_fdt:
> -	kho_unpreserve_free(fdt_out);
> -	pr_err("failed to prepare LUO FDT: %d\n", err);
> +	pr_err("failed to prepare LUO state: %d\n", err);
>  
>  	return err;
>  }
> @@ -230,7 +195,7 @@ static int __init luo_late_startup(void)
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	err = luo_fdt_setup();
> +	err = luo_state_setup();
>  	if (err)
>  		luo_global.enabled = false;
>  
> -- 
> 2.53.0
> 

