Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Okrx3-0000R2-7p
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 05:09:38 +0000
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<AANLkTimM0H0ryre3pXsXQ6c0e3=v_36-h0TsXzriMWXe@mail.gmail.com>
	<faf83501-1e53-459d-88ed-2ac5963a37f2@email.android.com>
	<AANLkTimtH41djAF5OxXCeVS8cHg_JCBd+wQ1iT1BUWgX@mail.gmail.com>
In-Reply-To: <AANLkTimtH41djAF5OxXCeVS8cHg_JCBd+wQ1iT1BUWgX@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 15 Aug 2010 22:08:43 -0700
Message-ID: <8f5e697c-e9ae-4453-aa7a-7086dd156cc9@email.android.com>
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
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, tglx@linutronix.de, vgoyal@redhat.com

For the 1:1 map we probably should make all pages executable; other things need it too, but we shouldn't have it mapped in except when needed.

"huang ying" <huang.ying.caritas@gmail.com> wrote:

>On Mon, Aug 16, 2010 at 11:27 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>> No, it should not be dynamic; rather we should unify all the users who need a 1:1 map and just keep that page table set around.
>
>Agree. One known issue of global 1:1 map is that we need to make at
>least part of page table PAGE_KERNEL_EXEC for EFI runtime code, and
>change_page_attr can not be used before page allocator is available.
>
>Best Regards,
>Huang Ying

-- 
Sent from my mobile phone.  Please pardon any lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
