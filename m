Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vx0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQk6O-0006CK-8O
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 18:20:57 +0000
Received: by vcge1 with SMTP id e1so949288vcg.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 10:20:51 -0800 (PST)
Subject: Re: Crash during vmcore_init
From: Tim Hartrick <tim@edgecast.com>
In-Reply-To: <4EC31E55.6040809@redhat.com>
References: <1318376345.2050.20.camel@boudreau>
 <j9r5m5$b18$1@dough.gmane.org> <1321296650.2066.17.camel@boudreau>
 <4EC21F67.10905@redhat.com> <1321396371.4198.5.camel@boudreau>
 <4EC31E55.6040809@redhat.com>
Date: Wed, 16 Nov 2011 10:20:47 -0800
Message-ID: <1321467647.2137.4.camel@boudreau>
Mime-Version: 1.0
Reply-To: tim@edgecast.com
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
To: Dave Young <dyoung@redhat.com>
Cc: tj@kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Dave,

On Wed, 2011-11-16 at 10:22 +0800, Dave Young wrote:
> On 11/16/2011 06:32 AM, Tim Hartrick wrote:
> 
> > 
> > Dave,
> > 
> > I tested with
> > 
> > linux-image-3.1.1-030101-generic_3.1.1-030101.201111111651_amd64.deb
> > 
> > which, as far as I know, is the Ubuntu build of the latest stable.
> > Below are the results.
> > 
> > [    1.427457] ioremap: invalid physical address 5800000000000
> 
> 
> Hi, thanks for the testing
> 
> Can you applied the debug patch to see if it's per cpu problem?
> 
> Don't need test kdump, just
> cd /sys/devices/system/cpu
> cat cpu[x]/crash_notes
> 
> probably cat crash notes of cpu number other than 0 will get the invalid
> address
> 

Using 3.1.1 stable with your patch.  See below.


tim

# for i in /sys/devices/system/cpu/cpu[0-9]*/crash_notes; do cat $i; done
5800000000000
5800000000000
5800000000000
5800000000000
5800000000000
5800000000000
5800000000000
5800000000000

dmesg:

[  277.276349] per cpu addr ffff880c7fc19ad0
[  277.276352] addr is not in vmalloc area
[  277.277545] per cpu addr ffff880667c19ad0
[  277.277548] addr is not in vmalloc area
[  277.278832] per cpu addr ffff880c7fc39ad0
[  277.278835] addr is not in vmalloc area
[  277.280175] per cpu addr ffff880667c39ad0
[  277.280178] addr is not in vmalloc area
[  277.281406] per cpu addr ffff880c7fc59ad0
[  277.281409] addr is not in vmalloc area
[  277.282592] per cpu addr ffff880667c59ad0
[  277.282594] addr is not in vmalloc area
[  277.284019] per cpu addr ffff880c7fc79ad0
[  277.284022] addr is not in vmalloc area
[  277.285251] per cpu addr ffff880667c79ad0
[  277.285254] addr is not in vmalloc area









_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
