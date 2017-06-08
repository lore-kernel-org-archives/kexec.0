Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIr47-0005MY-WA
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 06:37:10 +0000
Received: by mail-pg0-f49.google.com with SMTP id a70so12852296pge.3
 for <kexec@lists.infradead.org>; Wed, 07 Jun 2017 23:36:47 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH v4 1/2] makedumpfile: add runtime kaslr
 offset if it exists
References: <cover.1495767738.git.panand@redhat.com>
 <302c16ede3723264ca0abb5eef9c9f553ffcfbd7.1495767738.git.panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <f603a814-d112-fa67-ac89-0b9173b4ed7c@redhat.com>
Date: Thu, 8 Jun 2017 12:06:39 +0530
MIME-Version: 1.0
In-Reply-To: <302c16ede3723264ca0abb5eef9c9f553ffcfbd7.1495767738.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: xlpang@redhat.com, dyoung@redhat.com, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, bhe@redhat.com

Hi Atsushi,

On Friday 26 May 2017 08:36 AM, Pratyush Anand wrote:
> +#define get_kaslr_offset(X)	FALSE
>  #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
>  #define get_xen_info_arch(X) get_xen_info_arm64(X)
>  #define is_phys_addr(X)		stub_true_ul(X)
> @@ -851,6 +857,7 @@ unsigned long long vaddr_to_paddr_arm(unsigned long vaddr);
>  #define get_phys_base()		get_phys_base_arm()
>  #define get_machdep_info()	get_machdep_info_arm()
>  #define get_versiondep_info()	stub_true()
> +#define get_kaslr_offset(X)	FALSE


It seems that using stub_false() would be better than FALSE.

I see, its not yet in upstream/devel branch.
So, Either you can edit them before applying or may be I can send v5.

Please let me know.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
