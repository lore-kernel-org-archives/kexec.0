Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ss9RF-0005gm-J9
 for kexec@lists.infradead.org; Fri, 20 Jul 2012 09:23:58 +0000
Received: by yhjj52 with SMTP id j52so4036625yhj.36
 for <kexec@lists.infradead.org>; Fri, 20 Jul 2012 02:23:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120719140826.GD2761@redhat.com>
References: <20120718171812.GC21746@redhat.com>
 <CAPXgP12PioibfQhtAB0fCzL1MXmZvfvQqOGu_ZM0D8Sx4Vq7+w@mail.gmail.com>
 <20120718175625.GD21746@redhat.com>
 <CAPXgP12YasX6mBVOamO8Tk1mcFJ04XWh5CjuTRxhRShncgVCtA@mail.gmail.com>
 <20120719135736.GC2761@redhat.com> <20120719140826.GD2761@redhat.com>
From: Kay Sievers <kay@vrfy.org>
Date: Fri, 20 Jul 2012 11:23:10 +0200
Message-ID: <CAPXgP13W_aqky++LkHeHBUzKFTYNiTJQpchpHLCVDAdYihu5ig@mail.gmail.com>
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

On Thu, Jul 19, 2012 at 4:08 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Jul 19, 2012 at 09:57:36AM -0400, Vivek Goyal wrote:
>> On Thu, Jul 19, 2012 at 11:38:57AM +0200, Kay Sievers wrote:

>> > If we would swap the 5 + 3 bit field byte declaration, and add
>> > __packed, we can still not rely on the level to be consistently the
>> > lower 3 bits of the byte, right?
>
> I think I missed your point in last response. Are you saying that retain
> bit fields  for flags and level, and add __packed() and that will make sure
> level bits are always lowest 3bits?

It was more a question, I don't know how reliable that would be.

> I am really not sure how that is going
> to work. Also if you want to add more fields to struct log down the line,
> it will be a problem to determine the offset of byte where level bits are
> stored.

I guess, we could make sure that it's always the lowest 3 bits of a
byte. But the question if that is safe to do at all still remains. :)

Kay

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
