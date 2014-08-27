Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1409099608.21254.16.camel@smoke>
Subject: Re: [PATCH 0/5] kexec: minor fixups and enhancements
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 26 Aug 2014 17:33:28 -0700
In-Reply-To: <20140825165916.GC14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <20140825165916.GC14379@redhat.com>
Mime-Version: 1.0
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

Hi Vivek,

On Mon, 2014-08-25 at 12:59 -0400, Vivek Goyal wrote:
> Does arm64 has secureboot? If yes, then it might make sense to
> enable the new syscall kexec_file_load() on arm64 instead of trying
> to make old syscall work first.

Yes, arm64 should support secureboot, but I have not looked into it.

When do you expect syscall kexec_file_load to get merged?  I won't wait
until then to push my current kexec work.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
