Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www262.sakura.ne.jp ([202.181.97.72])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdFmT-0002th-FA
 for kexec@lists.infradead.org; Wed, 11 Jul 2018 14:08:02 +0000
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6BE7ShU025937
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2018 23:07:28 +0900 (JST)
 (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
 (authenticated bits=0)
 by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6BE7SWB025934
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2018 23:07:28 +0900 (JST)
 (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Fwd: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
References: <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f14c277e-99a4-af6c-c220-7e2c6c831694@i-love.sakura.ne.jp>
Date: Wed, 11 Jul 2018 23:07:33 +0900
MIME-Version: 1.0
In-Reply-To: <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
Content-Language: en-US
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
To: kexec@lists.infradead.org

Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
To: Linus Torvalds <torvalds@linux-foundation.org>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Sat, 7 Jul 2018 08:10:08 +0900

Hello Ken'ichi,

I noticed that makedumpfile ( https://sourceforge.net/p/makedumpfile/code/ )
can no longer detect kernel version correctly because "struct uts_namespace"
(which is exposed to userspace via vmcoreinfo) is subjected to randomization
by GCC_PLUGIN_RANDSTRUCT kernel config option since 4.13.

The code was introduced by below commit.

  commit bfc8fe181c822ad0d8495ceda3c7109a407192f0
  Author: ken1_ohmichi <ken1_ohmichi>
  Date:   Fri Dec 22 07:41:14 2006 +0000

      linux-2.6.19 support.
      On linux-2.6.18 or former, the release information could be gotten from
      the symbol "system_utsname". But on linux-2.6.19, it can be done from the
      symbol "init_uts_ns". A new makedumpfile can get the release information
      from the existing symbol.

Can you detect kernel version without using "struct uts_namespace" ?

On 2018/07/07 1:11, Linus Torvalds wrote:
> On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> I noticed that makedumpfile utility is failing to check kernel version, for
>> it depends on offset of "struct uts_namespace"->name being sizeof(int).
> 
> For something like this, we fix makedumpfile instead. This is not a
> "user program" using system calls etc, this is something that delves
> into the kernel dump and tries to make sense of it.
> 
> Where is the makedumpfile source code? What is it trying to do, and why?
> 
> One option is to just say "hey, you can't make much sense of a
> randomized kernel dump anyway, so don't even try".
> 
>                  Linus
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
