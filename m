Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound.mse2.exchange.ms ([69.25.50.247]
	helo=mse2fe1.mse2.exchange.ms)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZI8g-000504-Ct
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 04:00:26 +0000
Message-ID: <47D7523A.9080102@bluelane.com>
Date: Tue, 11 Mar 2008 19:47:06 -0800
From: Piet Delaney <pdelaney@bluelane.com>
MIME-Version: 1.0
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>		<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>		<47D19114.1090700@am.sony.com>	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>	<47D6B92D.2020205@am.sony.com>
	<47D6D406.8050209@am.sony.com> <47D73003.8060208@bluelane.com>
	<47D7349E.90409@am.sony.com>
In-Reply-To: <47D7349E.90409@am.sony.com>
Reply-To: pdelaney@bluelane.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0186095253=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Rajasekaran P <rajasekaran83@gmail.com>, kexec@lists.infradead.org, piet@bluelane.com

This is a multi-part message in MIME format.
--===============0186095253==
Content-Type: multipart/alternative;
	boundary="------------090104030201060801060607"

This is a multi-part message in MIME format.
--------------090104030201060801060607
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Geoff Levand wrote:
> Pete/Piet Delaney wrote:
>   
>> Geoff Levand wrote:
>> | Geoff Levand wrote:
>> |> Rajasekaran P wrote:
>> |>> Hi Geoff,
>> |>> Thanks for your information.
>> |>>
>> |>> I used latest kexec tools with 2.6.23 kernel built with ps3_defconfig.
>> |>> This kernel boots normally on PS3. But when I  add "crashkernel"
>> |>> argument, it goes on hang.
>> |>>
>> |>> # kexec --command-line="video=ps3fb:mode:166 rhgb root=/dev/ps3da3
>> |>> crashkernel=128M@32M" \
>> |>> --initrd=/boot/initrd-2.6.23.img \
>> |>> -l /boot/vmlinux-2.6.23
>> |>>
>> |>> # taskset 1 kexec e
>> |>>
>> |>> Nothing happens after this. As you said earlier in your mail, I am not
>> |>> getting any PRINTK outputs from kernel on screen.
>>
>> I was wondering about bringing in the printf() code from purgatory
>> and using that to print info about what's going on in the kexec code.
>> The standalone printf() might come in handy in other places; Ex: kgdb
>> stub. If it was in a library it could also be used during kernel
>> decompression to inform on problems occurring, like checksum errors.
>>     
>
> When the first stage kernel goes down it releases all hypervisor
> resources so that whatever boots next can successful open those
> resources.  The frame buffer is one of those resources that are
> released, and after it is, there will be no more output to the
> display until the second stage image brings up its display.  It
> is not a matter of adding print statements or string formatting.
>   

Oh, I thought you experienced the same problem I had
with printk() calls in some of the kexec functions making
it no longer work. I was considering changing my KEXEC_DEBUG()
macros to using printf() instead of printk() and importing
the purgatory printf() code.
> -Geoff
>
>   


--------------090104030201060801060607
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1252"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Geoff Levand wrote:
<blockquote cite="mid:47D7349E.90409@am.sony.com" type="cite">
  <pre wrap="">Pete/Piet Delaney wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Geoff Levand wrote:
| Geoff Levand wrote:
|&gt; Rajasekaran P wrote:
|&gt;&gt; Hi Geoff,
|&gt;&gt; Thanks for your information.
|&gt;&gt;
|&gt;&gt; I used latest kexec tools with 2.6.23 kernel built with ps3_defconfig.
|&gt;&gt; This kernel boots normally on PS3. But when I  add "crashkernel"
|&gt;&gt; argument, it goes on hang.
|&gt;&gt;
|&gt;&gt; # kexec --command-line="video=ps3fb:mode:166 rhgb root=/dev/ps3da3
|&gt;&gt; crashkernel=128M@32M" \
|&gt;&gt; --initrd=/boot/initrd-2.6.23.img \
|&gt;&gt; -l /boot/vmlinux-2.6.23
|&gt;&gt;
|&gt;&gt; # taskset 1 kexec e
|&gt;&gt;
|&gt;&gt; Nothing happens after this. As you said earlier in your mail, I am not
|&gt;&gt; getting any PRINTK outputs from kernel on screen.

I was wondering about bringing in the printf() code from purgatory
and using that to print info about what's going on in the kexec code.
The standalone printf() might come in handy in other places; Ex: kgdb
stub. If it was in a library it could also be used during kernel
decompression to inform on problems occurring, like checksum errors.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
When the first stage kernel goes down it releases all hypervisor
resources so that whatever boots next can successful open those
resources.  The frame buffer is one of those resources that are
released, and after it is, there will be no more output to the
display until the second stage image brings up its display.  It
is not a matter of adding print statements or string formatting.
  </pre>
</blockquote>
<br>
Oh, I thought you experienced the same problem I had<br>
with printk() calls in some of the kexec functions making<br>
it no longer work. I was considering changing my KEXEC_DEBUG()<br>
macros to using printf() instead of printk() and importing <br>
the purgatory printf() code.<br>
<blockquote cite="mid:47D7349E.90409@am.sony.com" type="cite">
  <pre wrap="">
-Geoff

  </pre>
</blockquote>
<br>
</body>
</html>

--------------090104030201060801060607--


--===============0186095253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0186095253==--

