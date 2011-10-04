Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.elliptictech.com ([209.217.122.41]
	helo=mail.ellipticsemi.com)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RB6Xv-0003Q1-Ti
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 15:04:40 +0000
Date: Tue, 4 Oct 2011 11:04:17 -0400
From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111004150417.GA23604@elliptictech.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003073203.GA22694@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On 2011-10-03 13:02 +0530, K.Prasad wrote:
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 08363b0..483b2fc 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -238,6 +238,34 @@ static atomic_t mce_paniced;
>  static int fake_panic;
>  static atomic_t mce_fake_paniced;
>  
> +void arch_add_nocoredump_note(u32 *buf)
> +{
> +	struct elf_note note;
> +	const char note_name[] = "PANIC_MCE";

        static const ...

> +	const char desc_msg[] = "Crash induced due to a fatal machine "
> +				"check error";

        likewise.

Please don't break string literals onto multiple lines like this, since
it prevents users from finding the string using "grep".

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
