Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sat, 19 Sep 2020 10:14:13 -0700
In-Reply-To: <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-2-arnd@arndb.de>
 <20200919053514.GI30063@infradead.org>
 <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
From: hpa@zytor.com
Message-ID: <85F32523-4E9E-443A-A150-10A9E5EB0CE3@zytor.com>
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
To: Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On September 19, 2020 9:23:22 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Fri, Sep 18, 2020 at 10:35 PM Christoph Hellwig <hch@infradead.org>
>wrote:
>>
>> On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
>> > sys_move_pages() is an optional syscall, and once we remove
>> > the compat version of it in favor of the native one with an
>> > in_compat_syscall() check, the x32 syscall table refers to
>> > a __x32_sys_move_pages symbol that may not exist when the
>> > syscall is disabled.
>> >
>> > Change the COND_SYSCALL() definition on x86 to also include
>> > the redirection for x32.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Adding the x86 maintainers and Brian Gerst.  Brian proposed another
>> problem to the mess that most of the compat syscall handlers used by
>> x32 here:
>>
>>    https://lkml.org/lkml/2020/6/16/664
>>
>> hpa didn't particularly like it, but with your and my pending series
>> we'll soon use more native than compat syscalls for x32, so something
>> will need to change..
>
>I'm fine with either solution.

My main objection was naming. x64 is a widely used synonym for x86-64, and so that is confusing.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
