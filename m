Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d856W-0003Ph-EK
 for kexec@lists.infradead.org; Tue, 09 May 2017 13:23:05 +0000
Received: by mail-pg0-f42.google.com with SMTP id 64so28587099pgb.3
 for <kexec@lists.infradead.org>; Tue, 09 May 2017 06:22:44 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH 0/2] Fix refiltering when kaslr enabled
References: <cover.1493272570.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <cf5a82bf-8232-f39f-7ab4-69250492d4a2@redhat.com>
Date: Tue, 9 May 2017 18:52:38 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EC6885@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "keescook@chromium.org" <keescook@chromium.org>, "bhe@redhat.com" <bhe@redhat.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Xunlei Pang <xlpang@redhat.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>

Hi Atsushi,

On Friday 28 April 2017 12:22 PM, Atsushi Kumagai wrote:
> Hello Pratyush,
>
> Thanks for your report, I have received this.
> I'm on vacation until Mar 8, I'll review it when I return from vacation.

Any further comment on it?
Otherwise, I will send a v2 after accommodating concern from Xunlei.

~Pratyush


>
> Thanks,
> Atsushi Kumagai
>
>> Hi All,
>>
>> We came across another failure in makedumpfile when kaslr is enabled. This
>> failure occurs when we try re-filtering. We try to erase some symbol from a
>> dumpfile which was copied/compressed from /proc/vmcore using makedumpfile.
>>
>> We have very limited symbol information in vmcoreinfo. So symbols to be
>> erased may not be available in vmcoreinfo and we look for it in vmlinux.
>> However,  symbol address from vmlinux is a static address which differs
>>from run time address with KASLR_OFFSET. Therefore, reading any "virtual
>> address of vmlinux" from vmcore is not possible.
>>
>> These patches finds runtime  KASLR offset and then calculates run time
>> address of symbols read from vmlinux.
>>
>> Since, I am not an expert of x86, and these patches touch x86 part of
>> makedumpfile, therefore I have CCed x86 experts. Please, provide your
>> review comment and let me know if you think there could have been a better
>> way to resolve this issue.
>>
>> thanks
>>
>> ~Pratyush
>>
>> Pratyush Anand (2):
>>  makedumpfile: add runtime kaslr offset if it exists
>>  x86_64: calculate page_offset in case of re-filtering
>>
>> arch/x86_64.c  | 45 +++++++++++++++++++++++++++++++++++++++++++--
>> erase_info.c   |  1 +
>> makedumpfile.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>> makedumpfile.h | 15 +++++++++++++++
>> 4 files changed, 103 insertions(+), 2 deletions(-)
>>
>> --
>> 2.9.3
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
