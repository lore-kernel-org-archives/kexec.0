Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aGrXK-00023C-Aw
 for kexec@lists.infradead.org; Wed, 06 Jan 2016 17:06:14 +0000
Date: Thu, 7 Jan 2016 01:08:32 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160106170832.GB25832@dhcp-128-25.nay.redhat.com>
References: <1452073845-1474-1-git-send-email-xlpang@redhat.com>
 <1452073845-1474-2-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452073845-1474-2-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/06/16 at 05:50pm, Xunlei Pang wrote:
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 819ab3f..cda867d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -536,3 +536,44 @@ overflow:
>  	return -ENOEXEC;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +static int
> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
> +{
> +	struct page *page;
> +	unsigned int nr_pages;
> +
> +	/* For physical range: [start, end] */
> +	if (!start || !end || start > end)
> +		return 0;

Hi, Xunlei.

        if (start > end)
                return 0;

See the below comment.
> +
> +	page = pfn_to_page(start >> PAGE_SHIFT);
> +	nr_pages = (end + PAGE_SIZE - start) >> PAGE_SHIFT;

As I commented in last version, it is better to cover the case if the
range from start to end acrosses two pages.

> +	if (protect)
> +		return set_pages_ro(page, nr_pages);
> +	else
> +		return set_pages_rw(page, nr_pages);
> +}
> +
> +static void kexec_mark_crashkres(bool protect)
> +{
> +	unsigned long control;
> +
> +	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);

Adding the following if test to test crashk_low_res is better. Then we
do not need to test if start or end is equal to 0 in kexec_mark_range.

        if (crashk_low_res.start != crashk_low_res.end) {
                kexec_mark_range(crashk_low_res.start,
                                crashk_low_res.end, protect);
        }

> +
> +	/* Don't touch the control code page used in crash_kexec().*/
> +	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
> +	/* Control code page is located in the 2nd page. */
> +	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
> +	kexec_mark_range(control + 2 * PAGE_SIZE, crashk_res.end, protect);

I think it is more readable, if we use MACRO KEXEC_CONTROL_PAGE_SIZE,
instead of using 2*PAGE_SIZE directly.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
