Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ol9Hq-0001xg-Mf
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 23:40:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<AANLkTimM0H0ryre3pXsXQ6c0e3=v_36-h0TsXzriMWXe@mail.gmail.com>
	<faf83501-1e53-459d-88ed-2ac5963a37f2@email.android.com>
	<AANLkTimtH41djAF5OxXCeVS8cHg_JCBd+wQ1iT1BUWgX@mail.gmail.com>
	<8f5e697c-e9ae-4453-aa7a-7086dd156cc9@email.android.com>
Date: Mon, 16 Aug 2010 16:39:51 -0700
In-Reply-To: <8f5e697c-e9ae-4453-aa7a-7086dd156cc9@email.android.com>
	(H. Peter Anvin's message of "Sun, 15 Aug 2010 22:08:43 -0700")
Message-ID: <m1ocd2i0u0.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
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
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, huang ying <huang.ying.caritas@gmail.com>, vgoyal@redhat.com


"H. Peter Anvin" <hpa@zytor.com> writes:
> "huang ying" <huang.ying.caritas@gmail.com> wrote:
>
>>On Mon, Aug 16, 2010 at 11:27 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>> No, it should not be dynamic; rather we should unify all the users
>>> who need a 1:1 map and just keep that page table set around.

We still want to restore cr3 from the local task structure as soon
as is reasonable, as an identity mapped page table will have page 0
mapped and thus hide null pointer dereferences.

>>Agree. One known issue of global 1:1 map is that we need to make at
>>least part of page table PAGE_KERNEL_EXEC for EFI runtime code, and
>>change_page_attr can not be used before page allocator is available.

> For the 1:1 map we probably should make all pages executable; other
> things need it too, but we shouldn't have it mapped in except when
> needed.

We need to be careful in the setup of the global page table so that
we are in sync with the pat structure for the attributes pages
are mapped so that we don't map a page as cached and uncached
at the same time.  Otherwise we could accidentally get cache
corruption.  To do that would seem to mean change_page_attr
is relevant at least after we switch from our default set of
page permissions.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
