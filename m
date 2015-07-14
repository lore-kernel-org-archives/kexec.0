Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55A46C3D.7000208@hitachi.com>
Date: Tue, 14 Jul 2015 10:56:13 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org> <20150713202611.GA16525@fifo99.com>
In-Reply-To: <20150713202611.GA16525@fifo99.com>
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
To: dwalker@fifo99.com, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hello Eric and Daniel,

(2015/07/14 5:26), dwalker@fifo99.com wrote:
> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>>
>>> You can call panic notifiers and kmsg dumpers before kdump by
>>> specifying "crash_kexec_post_notifiers" as a boot parameter.
>>> However, it doesn't make sense if kdump is not available.  In that
>>> case, disable "crash_kexec_post_notifiers" boot parameter so that
>>> you can't change the value of the parameter.
>>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> You are confusing kexec on panic and CONFIG_CRASH_DUMP
>> which is about the tools for reading the state of the previous kernel.

You are right.  I mistook the meaning of CONFIG_CRASH_DUMP.

> I think it would make sense if he just replaced "kdump" with "kexec".

If a user specified crash_kexec_post_notifiers option with kexec
being totally disabled, it just disables notifier and kmsg dumper calls
(please see PATCH 3/3). So as Daniel said, I also think it makes sense
to hide crash_kexec_post_notifiers option if kexec is disabled.

Regards,

-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
