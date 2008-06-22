Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.181])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KAVuW-0004qB-HP
	for kexec@lists.infradead.org; Sun, 22 Jun 2008 20:11:40 +0000
Received: by py-out-1112.google.com with SMTP id a73so1406247pye.2
	for <kexec@lists.infradead.org>; Sun, 22 Jun 2008 13:11:39 -0700 (PDT)
Message-ID: <86802c440806221311q5a65cdb6me24b45de5657359c@mail.gmail.com>
Date: Sun, 22 Jun 2008 13:11:38 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
In-Reply-To: <20080622215635.7a0ebaae@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<1213977420-1555-4-git-send-email-bwalle@suse.de>
	<86802c440806201334s30cbc685se44326812841fdd2@mail.gmail.com>
	<20080622215635.7a0ebaae@kopernikus.site>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Sun, Jun 22, 2008 at 12:56 PM, Bernhard Walle <bwalle@suse.de> wrote:
> * "Yinghai Lu" <yhlu.kernel@gmail.com> [2008-06-20 13:34]:
>>
>> any problem that you encountered without this patch?
>
> Sorry, forgot to answer that question.
>
> Yes, if you use mem=3G and take a dump, kexec builds the ELF core
> headers for the full memory size, which means that the dump is as large
> as the physical memory of the machine is, which doesn't make sense.

can we use e820_update_range instead? so e820_setup_gap still can get
correct value?

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
