Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound.mse2.exchange.ms ([69.25.50.247]
	helo=mse2fe1.mse2.exchange.ms)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUxpQ-0004rZ-Ce
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 00:58:29 -0400
Message-ID: <46E61D77.1050001@bluelane.com>
Date: Mon, 10 Sep 2007 21:45:43 -0700
From: Piet Delaney <pdelaney@bluelane.com>
MIME-Version: 1.0
Subject: Re: [Crash-utility] Re: [PATCH 0/2] vmcoreinfo support for
	dump	filtering #2
References: <20070907175746oomichi@mail.jp.nec.com>	<20070910113521.755d0433.rdunlap@xenotime.net>
	<20070911035250.GA5053@in.ibm.com>
In-Reply-To: <20070911035250.GA5053@in.ibm.com>
Reply-To: pdelaney@bluelane.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1907243642=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, kexec-ml <kexec@lists.infradead.org>

This is a multi-part message in MIME format.
--===============1907243642==
Content-Type: multipart/alternative;
	boundary="------------010800070100020307060903"

This is a multi-part message in MIME format.
--------------010800070100020307060903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vivek Goyal wrote:

How do I subscribe to the kexec mailing list on lists.infradead.org?
I tried majordomo, as on vger, but it didn't work.

-piet

> On Mon, Sep 10, 2007 at 11:35:21AM -0700, Randy Dunlap wrote:
>   
>> On Fri, 7 Sep 2007 17:57:46 +0900 Ken'ichi Ohmichi wrote:
>>
>>     
>>> Hi,
>>>       
>>> I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
>>> I updated the patches for linux and kexec-tools.
>>>
>>> PATCH SET:
>>> [1/2] [linux-2.6.22] Add vmcoreinfo
>>>   The patch is for linux-2.6.22.
>>>   The patch adds the vmcoreinfo data. Its address and size are output
>>>   to /sys/kernel/vmcoreinfo.
>>>
>>> [2/2] [kexec-tools] Pass vmcoreinfo's address and size
>>>   The patch is for kexec-tools-testing-20070330.
>>>   (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
>>>   kexec command gets the address and size of the vmcoreinfo data from
>>>   /sys/kernel/vmcoreinfo, and passes them to the second kernel through
>>>   ELF header of /proc/vmcore. When the second kernel is booting, the
>>>   kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
>>>   segment into /proc/vmcore.
>>>       
>> Hi,
>> When using the vmcoreinfo patches, what tool(s) are available for
>> analyzing the vmcore (dump) file?  E.g., lkcd or crash or just gdb?
>>
>> gdb works for me, but I tried to use crash (4.0-4.6 from
>> http://people.redhat.com/anderson/) and crash complained:
>>
>> crash: invalid kernel virtual address: 0  type: "cpu_pda entry"
>>
>> Should crash work, or does it need to be modified?
>>
>>     
>
> Hi Randy,
>
> Crash should just work. It might broken on latest kernel. Copying it
> to crash-utility mailing list. Dave will be able to tell us better.
>
>   
>> This is on a 2.6.23-rc3 kernel with vmcoreinfo patches and a dump file
>> with -l 31 (dump level 31, omitting all possible pages).
>>
>>     
>
> Thanks
> Vivek
>
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
>   


--------------010800070100020307060903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Vivek Goyal wrote:<br>
<br>
How do I subscribe to the kexec mailing list on lists.infradead.org?<br>
I tried majordomo, as on vger, but it didn't work.<br>
<br>
-piet<br>
<br>
<blockquote cite="mid:20070911035250.GA5053@in.ibm.com" type="cite">
  <pre wrap="">On Mon, Sep 10, 2007 at 11:35:21AM -0700, Randy Dunlap wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Fri, 7 Sep 2007 17:57:46 +0900 Ken'ichi Ohmichi wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi,
      </pre>
    </blockquote>
    <blockquote type="cite">
      <pre wrap="">I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
I updated the patches for linux and kexec-tools.

PATCH SET:
[1/2] [linux-2.6.22] Add vmcoreinfo
  The patch is for linux-2.6.22.
  The patch adds the vmcoreinfo data. Its address and size are output
  to /sys/kernel/vmcoreinfo.

[2/2] [kexec-tools] Pass vmcoreinfo's address and size
  The patch is for kexec-tools-testing-20070330.
  (<a class="moz-txt-link-freetext" href="http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/">http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/</a>)
  kexec command gets the address and size of the vmcoreinfo data from
  /sys/kernel/vmcoreinfo, and passes them to the second kernel through
  ELF header of /proc/vmcore. When the second kernel is booting, the
  kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
  segment into /proc/vmcore.
      </pre>
    </blockquote>
    <pre wrap="">Hi,
When using the vmcoreinfo patches, what tool(s) are available for
analyzing the vmcore (dump) file?  E.g., lkcd or crash or just gdb?

gdb works for me, but I tried to use crash (4.0-4.6 from
<a class="moz-txt-link-freetext" href="http://people.redhat.com/anderson/">http://people.redhat.com/anderson/</a>) and crash complained:

crash: invalid kernel virtual address: 0  type: "cpu_pda entry"

Should crash work, or does it need to be modified?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hi Randy,

Crash should just work. It might broken on latest kernel. Copying it
to crash-utility mailing list. Dave will be able to tell us better.

  </pre>
  <blockquote type="cite">
    <pre wrap="">This is on a 2.6.23-rc3 kernel with vmcoreinfo patches and a dump file
with -l 31 (dump level 31, omitting all possible pages).

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Thanks
Vivek

--
Crash-utility mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Crash-utility@redhat.com">Crash-utility@redhat.com</a>
<a class="moz-txt-link-freetext" href="https://www.redhat.com/mailman/listinfo/crash-utility">https://www.redhat.com/mailman/listinfo/crash-utility</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------010800070100020307060903--


--===============1907243642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1907243642==--

