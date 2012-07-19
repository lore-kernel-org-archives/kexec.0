Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SrnCa-0003AV-TK
 for kexec@lists.infradead.org; Thu, 19 Jul 2012 09:39:22 +0000
Received: by yenr9 with SMTP id r9so2718607yen.36
 for <kexec@lists.infradead.org>; Thu, 19 Jul 2012 02:39:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120718175625.GD21746@redhat.com>
References: <20120718171812.GC21746@redhat.com>
 <CAPXgP12PioibfQhtAB0fCzL1MXmZvfvQqOGu_ZM0D8Sx4Vq7+w@mail.gmail.com>
 <20120718175625.GD21746@redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 19 Jul 2012 11:38:57 +0200
Message-ID: <CAPXgP12YasX6mBVOamO8Tk1mcFJ04XWh5CjuTRxhRShncgVCtA@mail.gmail.com>
Subject: Re: [PATCH] printk: Export struct log size and member offsets through
 vmcoreinfo
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Greg Kroah-Hartmann <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Jul 18, 2012 at 7:56 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Wed, Jul 18, 2012 at 07:27:08PM +0200, Kay Sievers wrote:
>> On Wed, Jul 18, 2012 at 7:18 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>> > Currently I am not exporting log "level" info as that is a bitfield and
>> > offsetof() bitfields can't be calculated.
>>
>> We could make the level the lower 3 bits of the byte, export the byte,
>> and define that only 3 bits of the byte are valid? Would that help?
>
> Yes, that should work. Here is the prototype patch which stores 5 bits
> of flag and 3 bits of level in a byte. I have not tested it yet, but
> if you like the approach, I will test it.

> -       u8 flags:5;             /* internal record flags */
> -       u8 level:3;             /* syslog level */
> +       u8 flags_level;         /* 5 bit internal record flags, 3 bits syslog

Looks ok.

If we would swap the 5 + 3 bit field byte declaration, and add
__packed, we can still not rely on the level to be consistently the
lower 3 bits of the byte, right?

Thanks,
Kay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
