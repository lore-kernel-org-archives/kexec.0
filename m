Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f170.google.com ([209.85.216.170])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Okrmf-0006Xy-D6
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 04:58:54 +0000
Received: by qyk35 with SMTP id 35so2982292qyk.15
	for <kexec@lists.infradead.org>; Sun, 15 Aug 2010 21:58:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <faf83501-1e53-459d-88ed-2ac5963a37f2@email.android.com>
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<AANLkTimM0H0ryre3pXsXQ6c0e3=v_36-h0TsXzriMWXe@mail.gmail.com>
	<faf83501-1e53-459d-88ed-2ac5963a37f2@email.android.com>
Date: Mon, 16 Aug 2010 12:58:52 +0800
Message-ID: <AANLkTimtH41djAF5OxXCeVS8cHg_JCBd+wQ1iT1BUWgX@mail.gmail.com>
Subject: Re: [PATCH][EFI] Run EFI in physical mode
From: huang ying <huang.ying.caritas@gmail.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, tglx@linutronix.de, vgoyal@redhat.com

On Mon, Aug 16, 2010 at 11:27 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> No, it should not be dynamic; rather we should unify all the users who need a 1:1 map and just keep that page table set around.

Agree. One known issue of global 1:1 map is that we need to make at
least part of page table PAGE_KERNEL_EXEC for EFI runtime code, and
change_page_attr can not be used before page allocator is available.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
