Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UqxCg-0005NV-7X
 for kexec@lists.infradead.org; Mon, 24 Jun 2013 03:12:31 +0000
Message-ID: <51C7B8EF.6050002@redhat.com>
Date: Mon, 24 Jun 2013 11:11:43 +0800
From: Baoquan He <bhe@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
 <51C24656.1080509@jp.fujitsu.com> <51C28E41.2080903@redhat.com>
 <20130620154334.33a09ca47ec66a1c834db08e@mxc.nes.nec.co.jp>
 <51C39F2C.6090002@jp.fujitsu.com> <51C3F1BF.7000508@redhat.com>
 <51C40D7A.9070504@hp.com>
In-Reply-To: <51C40D7A.9070504@hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org

On 06/21/2013 04:23 PM, Jingbai Ma wrote:
>>>>>>
>>>>>> One of my solution is conversely to delete short options, and I don't
>>>>>> think it problem because the short options are only implicitly
>>>>>> exported
>>>>>> without explicit description on such as manual page and help message.
>>>>>
>>>>>
>>>>> Yeah, deleting short options is also a good method, let's wait and see
>>>>> what the maintainer say.
>>>>
>>>> I agree to delete short options.
>>>> Could you re-send the patch ?
>>>>
>>>
>>> BTW, we can assign non-printable characters as short options. Normally
>>> we don't type non-printable characters on console, so it's for free.
>>>
>>
>> Hi,
>> I think it's good idea. In kexec, some options use below short option
>> with a large value. With these indicative MACRO as short option, it will
>> make code more readable.
>>
>> Then all old short options can be replaced with them.
>>
>> #define OPT_MEM_MIN             256
>> #define OPT_MEM_MAX             257
>> #define OPT_REUSE_INITRD        258
>> #define OPT_LOAD_PRESERVE_CONTEXT 259
>> #define OPT_LOAD_JUMP_BACK_HELPER 260
>> #define OPT_ENTRY               261
>> #define OPT_MAX                 262
>>
> 
> But the value of char should only be from 0 to 255, so the value 256 to
> 262 couldn't be mapped to a single char.

As above discussion, printable short option is not needed, then it's
unnecessary to map value to a single char. Using short option just for
implementation.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
