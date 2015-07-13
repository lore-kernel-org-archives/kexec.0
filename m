Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Jul 2015 20:26:11 +0000
From: dwalker@fifo99.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150713202611.GA16525@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wpy82kqf.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, linux-arm-kernel@lists.infradead.org, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> 
> > You can call panic notifiers and kmsg dumpers before kdump by
> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > However, it doesn't make sense if kdump is not available.  In that
> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > you can't change the value of the parameter.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I think it would make sense if he just replaced "kdump" with "kexec".

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
