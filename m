Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1427477015.27739.30.camel@infradead.org>
Subject: Re: arm64 kexec hang
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 27 Mar 2015 10:23:35 -0700
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
To: Pratyush Anand <panand@redhat.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, Kyle McMartin <kmcmarti@redhat.com>

Hi Pratyush,

On Wed, 2015-03-25 at 15:55 +0530, Pratyush Anand wrote:
> So with following changes kexec load seems to complete without any 
> error. However, kexec reboot does not work yet, Nothing after bye 
> message :( (1st kernel booted with maxcpus=1)

'Bye!' doesn't mean much, other than the first kernel has
almost shutdown.  I recommend for debugging you either define
ARM64_DEBUG_PORT for the kexec-tools build, or have a suitable
earlyprintk= on the kernel command line.  See the read_sink()
routine in kexec-arm64.c.

Either of these will output something like this from the
purgatory code:

  I'm in purgatory
  purgatory: kernel_entry: 0000000080080000
  purgatory: dtb:          0000000080760000

Another option is to add my 'debugging: early putc' patch,
build the kernel with ARM64_DEBUG_PORT defined for your
 board.  This will output 'stext' when the second
stage kernel is entered

The kexec --lite option will bypass purgatory and should just
show 'stext'.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
