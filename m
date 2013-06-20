Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UpX7B-00038C-5A
 for kexec@lists.infradead.org; Thu, 20 Jun 2013 05:08:58 +0000
Message-ID: <51C28E41.2080903@redhat.com>
Date: Thu, 20 Jun 2013 13:08:17 +0800
From: Baoquan <bhe@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
 <51C24656.1080509@jp.fujitsu.com>
In-Reply-To: <51C24656.1080509@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On 06/20/2013 08:01 AM, HATAYAMA Daisuke wrote:

> 
>> makedumpfile has some options which has two 2 forms, long option
>> and short option. E.g. --help  |  -h
>>
>> In man page and help, only one of them are presented, user may complain
>> of this. Here add missing options.
>>
> 
> I guess the maintainer does so intentionally, I'm not sure of course.
> Characters for short options is limited resource, but now makedumpfile
> has considerably many options. We can no longer assign reasonable
> letters to each functionality with short options. For example, please
> look at the definition of longopts:
> 
> static struct option longopts[] = {
>         {"split", no_argument, NULL, 's'},
>         {"reassemble", no_argument, NULL, 'r'},
>         {"xen-syms", required_argument, NULL, 'y'},
>         {"xen-vmcoreinfo", required_argument, NULL, 'z'},
>         {"xen_phys_start", required_argument, NULL, 'P'},
>         {"message-level", required_argument, NULL, 'm'},
>         {"vtop", required_argument, NULL, 'V'},
>         {"dump-dmesg", no_argument, NULL, 'M'},
>         {"config", required_argument, NULL, 'C'},
>         {"help", no_argument, NULL, 'h'},
>         {"diskset", required_argument, NULL, 'k'},
>         {"non-cyclic", no_argument, NULL, 'Y'},
>         {"cyclic-buffer", required_argument, NULL, 'Z'},
>         {"eppic", required_argument, NULL, 'S'},
>         {"map-size", required_argument, NULL, 'A'},
>         {0, 0, 0, 0}
> };
> 
> I don't see any relationship on the last three options: non-cyclic vs Y,
> cyclic-buffer vs Z, eppic vs S and map-size vs A. I don't think there
> are users who use short options for these features.


Hi,

Thanks for telling. I totally understand that unmarched letters between
long and short options are truly annoying. But like current code, only
presenting long options in man page and help may cause complaint from QA
or customers.

> 
> One of my solution is conversely to delete short options, and I don't
> think it problem because the short options are only implicitly exported
> without explicit description on such as manual page and help message.


Yeah, deleting short options is also a good method, let's wait and see
what the maintainer say.

Baoquan
Thanks a lot


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
