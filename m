Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZAMyS-00046j-0A
 for kexec@lists.infradead.org; Wed, 01 Jul 2015 18:43:08 +0000
Message-ID: <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
In-Reply-To: <20150627082256.GE21646@localhost.localdomain>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
 <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
 <20150624033241.GA22348@localhost.localdomain>
 <558A25A3.60504@codeaurora.org>
 <20150627082256.GE21646@localhost.localdomain>
Date: Wed, 1 Jul 2015 18:42:46 -0000
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: "Azriel Samson" <asamson@codeaurora.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: virajm@codeaurora.org, Timur Tabi <timur@codeaurora.org>, asamson@codeaurora.org, kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com

Hi Pratyush,

I am working with Timur and we are testing your version of makedumpfile.
The tool is unable to get the kernel version and quits from check_release().

I tried to debug the vmcore file with gdb but the file looks corrupt.

Let me know if you have any ideas on what could be wrong?

> Hi Timur,
>
> On 23/06/2015:10:36:03 PM, Timur Tabi wrote:
>> Pratyush Anand wrote:
>> >I can try to find out some time in weekend to refactor arm64 code
>> >and then add 3 level, 4K support. May be I will need a Tested-by.
>>
>> We'd be more than happy to test any code from you promptly.  We're eager
>> to
>> get this to work.
>
> I have done the changes, hopefully it should work, but have not
> tested. Let me know, if it works will send them as formal patches
> to upstream.
>
> https://github.com/pratyushanand/makedumpfile.git : arm64_support
> (9b95423bcea0)
>
> ~Pratyush
>

-- =

Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,=
=A0
a Linux Foundation Collaborative Project


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
