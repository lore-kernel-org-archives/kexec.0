Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oa0-x22e.google.com ([2607:f8b0:4003:c02::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKUjz-0004hu-Oh
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 15:57:32 +0000
Received: by mail-oa0-f46.google.com with SMTP id m1so7698375oag.33
 for <kexec@lists.infradead.org>; Thu, 21 Aug 2014 08:57:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140820143315.GC16303@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
Date: Thu, 21 Aug 2014 10:57:09 -0500
Message-ID: <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
From: Kees Cook <keescook@chromium.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Wed, Aug 20, 2014 at 9:33 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Tue, Aug 19, 2014 at 05:07:24PM +0800, WANG Chao wrote:
>> On 08/18/14 at 10:57am, Vivek Goyal wrote:
>> > Hi Thomas,
>> >
>> > I think kexec is broken with CONFIG_RANDOMIZE_BASE=y. Chao had raised
>> > this issue some time back when this option was introduced. I don't
>> > remember the details though that why it is broken.

The "normal" problems with kaslr have to do with areas of memory that
shouldn't be stomped on, or if 1-to-1 page tables are not in place.
What state are the page tables in when doing the kexec, and how are
kernel parameters (including e820) passed?

>>
>> The following fix the problem for kdump case:
>>
>> commit 0d52644
>> Author: WANG Chao <chaowang@redhat.com>
>> Date:   Fri Mar 28 15:05:00 2014 +0800
>>
>>     x86, kaslr: add alternative way to locate kernel text mapping area

I don't see this in Linus's tree? Where can I find this commit?

>>
>>
>> For kexec case, it hangs in purgatory:
>>
>> [  556.859384] kexec: Starting new kernel
>> I'm in purgatory
>
> Chao,
>
> Do you know why does it hang in purgatory in case of kexec?
>
> Thanks
> Vivek

-Kees


-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
