Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.251])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXu6a-0006EY-BN
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 08:40:48 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1865099rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 01:40:47 -0700 (PDT)
Message-ID: <86802c440808260140q63bd97fdn428189501b83cf79@mail.gmail.com>
Date: Tue, 26 Aug 2008 01:40:47 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] [PATCH] Move $(LIBS) on the end
In-Reply-To: <20080826103454.51b80a7f@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <669d49e549978c2cd9bb.1219738609@halley.suse.de>
	<86802c440808260121i62ec7c17m8ffd7c0a0822da35@mail.gmail.com>
	<20080826103454.51b80a7f@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Tue, Aug 26, 2008 at 1:34 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * Yinghai Lu [2008-08-26 01:21]:
>>
>> On Tue, Aug 26, 2008 at 1:16 AM, Bernhard Walle <bwalle@suse.de> wrote:
>> > 1 file changed, 1 insertion(+), 2 deletions(-)
>> > kexec/Makefile |    3 +--
>> >
>> >
>> > To make static compilation work with
>> >
>> >    LDFLAGS=-static ./configure
>> >    make
>>
>> thanks. can you put that two lines into INSTALL.
>
> Adding is not possible since there is no such file. However, I hacked a
> small INSTALL file now, I hope that's ok, see the next patch mail.
>

there is one in the git tree

http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools.git;a=blob;f=INSTALL;h=e422868c2b9411c38949dd605d674455f96f1ae2;hb=HEAD

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
