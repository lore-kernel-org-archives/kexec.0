Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YaM7Y-00082Q-0r
 for kexec@lists.infradead.org; Tue, 24 Mar 2015 10:31:41 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <54F9D645.2050008@jp.fujitsu.com>
 <20150323034752.GD2068@dhcp-16-105.nay.redhat.com>
 <20150323071943.GA22765@gmail.com> <5510DA42.6040708@hitachi.com>
 <20150324071129.GA28619@gmail.com>
Date: Tue, 24 Mar 2015 05:27:10 -0500
In-Reply-To: <20150324071129.GA28619@gmail.com> (Ingo Molnar's message of
 "Tue, 24 Mar 2015 08:11:29 +0100")
Message-ID: <87619qzo5d.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kernel/panic/kexec: fix "crash_kexec_post_notifiers"
 option issue in oops path
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
To: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hidehiro.kawai.ez@hitachi.com, =?utf-8?B?SGF0YXlhbWEsIERhaXN1a2Uv55WR5bGxIOWkp+i8lA==?= <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, akpm@linux-foundation.org, bp@suse.de, Vivek Goyal <vgoyal@redhat.com>

Ingo Molnar <mingo@kernel.org> writes:

> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
>
>> > 
>> >   f06e5153f4ae ("kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers")
>> > 
>> > Was that crash_kexec() was called unconditionally after notifiers were 
>> > called, which should be fixed via the simple patch below (untested). 
>> > Looks much simpler than your fix.
>> 
>> No, Daisuke's patch is not for that case. [...]
>
> Yet the actual bug is in that commit, 'crash_kexec_post_notifiers' was 
> clearly not a no-op in the default case, against expectations.
>
> So the first step should be to restore the original behavior (my 
> patch), then should any new tweaks be added.

Honestly I think the proper fix is to simply revert f06e5153f4ae.

It was clearly not properly tested by the people who wanted it because
they came back quite a while later with additional bleh.

I think this pretty much counts as hitting the code doesn't work let's
remove it threshold.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
