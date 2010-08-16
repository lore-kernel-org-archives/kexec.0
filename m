Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ol9YR-0005n7-7E
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 23:57:24 +0000
Message-ID: <4C69CFC4.8020307@zytor.com>
Date: Mon, 16 Aug 2010 16:54:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>	<AANLkTimM0H0ryre3pXsXQ6c0e3=v_36-h0TsXzriMWXe@mail.gmail.com>	<faf83501-1e53-459d-88ed-2ac5963a37f2@email.android.com>	<AANLkTimtH41djAF5OxXCeVS8cHg_JCBd+wQ1iT1BUWgX@mail.gmail.com>	<8f5e697c-e9ae-4453-aa7a-7086dd156cc9@email.android.com>
	<m1ocd2i0u0.fsf@fess.ebiederm.org>
In-Reply-To: <m1ocd2i0u0.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, huang ying <huang.ying.caritas@gmail.com>, vgoyal@redhat.com

On 08/16/2010 04:39 PM, Eric W. Biederman wrote:
> 
> "H. Peter Anvin" <hpa@zytor.com> writes:
>> "huang ying" <huang.ying.caritas@gmail.com> wrote:
>>
>>> On Mon, Aug 16, 2010 at 11:27 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>> No, it should not be dynamic; rather we should unify all the users
>>>> who need a 1:1 map and just keep that page table set around.
> 
> We still want to restore cr3 from the local task structure as soon
> as is reasonable, as an identity mapped page table will have page 0
> mapped and thus hide null pointer dereferences.
> 

Absolutely!

>>> Agree. One known issue of global 1:1 map is that we need to make at
>>> least part of page table PAGE_KERNEL_EXEC for EFI runtime code, and
>>> change_page_attr can not be used before page allocator is available.
> 
>> For the 1:1 map we probably should make all pages executable; other
>> things need it too, but we shouldn't have it mapped in except when
>> needed.
> 
> We need to be careful in the setup of the global page table so that
> we are in sync with the pat structure for the attributes pages
> are mapped so that we don't map a page as cached and uncached
> at the same time.  Otherwise we could accidentally get cache
> corruption.  To do that would seem to mean change_page_attr
> is relevant at least after we switch from our default set of
> page permissions.

Quite, which is yet another reason to have a common global page table
for all the 1:1 users... right now this is all ad hoc.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
